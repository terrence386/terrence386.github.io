# prop 装饰器
Props是在元素上公开的自定义属性/属性，开发人员可以为其提供值。子组件不应该知道或引用父组件，因此应该使用道具将数据从父组件传递到子组件。组件需要使用@Prop（）decorator显式声明它们希望接收的道具。道具可以是数字、字符串、布尔值，甚至是对象或数组。默认情况下，当设置了用@Prop（）装饰器装饰的成员时，该组件将有效地重新呈现
```
import { Prop } from '@stencil/core';

...
export class TodoList {
  @Prop() color: string;
  @Prop() favoriteNumber: number;
  @Prop() isSelected: boolean;
  @Prop() myHttpService: MyHttpService;
}
```
在TodoList类中，通过this操作符访问Props。
```
logColor() {
  console.log(this.color)
}
```
外部，Prop设置在元素上。
```
<todo-list color="blue" favorite-number="24" is-selected="true"></todo-list>
```
JSX中 使用驼峰
```
<todo-list color="blue" favoriteNumber={24} isSelected="true"></todo-list>
```
也可以使用JS访问
```
const todoListElement = document.querySelector('todo-list');
console.log(todoListElement.myHttpService); // MyHttpService
console.log(todoListElement.color); // blue
```
##### Prop options 
Prop（opts？：PropOptions）decorator接受一个可选参数来指定某些选项，例如可变性、DOM属性的名称，或者属性的值是否应该反映到DOM中。
```
export interface PropOptions {
  attribute?: string;
  mutable?: boolean;
  reflect?: boolean;
```
##### Prop mutability 可变性
 重要的是要知道，在默认情况下，Prop在组件逻辑中是不可变的。一旦用户设置了一个值，组件就不能在内部更新它。

但是，可以通过将属性声明为可变的方式，从组件内部显式地允许对其进行变异，如下例所示：
```
import { Prop } from '@stencil/core';

...
export class NameElement {

  @Prop({ mutable: true }) name: string = 'Stencil';

  componentDidLoad() {
    this.name = 'Stencil 0.7.0';
  }
}
```
##### Attribute Name 属性名
属性和组件属性是强连接的，但不一定相同。虽然属性是一个HTML概念，但属性是面向对象编程中固有的JS概念。

在Prop中，应用于属性的@Prop（）装饰器将指示模具编译器也侦听DOM属性中的更改。

通常属性的名称与属性的名称相同，但情况并非总是如此。以以下组件为例：
```
import { Component, Prop } from '@stencil/core';

@Component({ tag: 'my-cmp' })
class Component {
  @Prop() value: string;
  @Prop() isValid: boolean;
  @Prop() controller: MyController;
}
```
此组件有3个属性，但编译器将只创建2个属性：value和isValid。
```
<my-cmp value="Hello" is-valid></my-cmp>
```
注意，控制器类型不是一个原语，因为DOM属性只能是字符串，所以有一个名为“controller”的相关DOM属性是没有意义的。

同时，isValid属性遵循camelCase命名，但属性不区分大小写，因此默认情况下属性名称将有效。

幸运的是，可以使用@Prop（）decorator的attribute选项更改此“默认”行为：
```
import { Component, Prop } from '@stencil/core';

@Component({ tag: 'my-cmp' })
class Component {
  @Prop() value: string;
  @Prop({ attribute: 'valid' }) isValid: boolean;
  @Prop({ attribute: 'controller' }) controller: MyController;
}
```
通过使用此选项，我们可以明确哪些属性具有关联的DOM属性及其名称。
##### Reflect Properties Values to Attributes 将属性值反映到属性
在某些情况下，保持props与属性同步可能很有用。在这种情况下，您可以将@Prop（）decorator中的reflect选项设置为true，因为它默认为false
```
@Prop({
  reflect: true
})
```
当“prop”设置为“reflect”时，意味着它们的值将在DOM中呈现为HTML属性：

以以下组件为例：
```
@Component({ tag: 'my-cmp' })
class Cmp {
  @Prop({ reflect: true }) message = 'Hello';
  @Prop({ reflect: false }) value = 'The meaning of life...';
  @Prop({ reflect: true }) number = 42;
}
```
demo
```
<my-cmp message="Hello" number="42"></my-cmp>
```
请注意，设置为“反射”（true）的属性将呈现为属性，而未设置为“反射”的属性则不会。
虽然没有设置为“反射”的属性（如“值”）没有呈现为属性，但这并不意味着它不存在——值属性仍然包含生命的意义。。
```
const cmp = document.querySelector('my-cmp');
console.log(cmp.value); // it prints 'The meaning of life...'
```
##### Prop default values and validation  prop默认值及校验
使用 @Watch() 来校验prop:
```
import { Prop, Watch } from '@stencil/core';

...
export class TodoList {
  @Prop() name: string = 'Stencil';

  @Watch('name')
  validateName(newValue: string, oldValue: string) {
    const isBlank = typeof newValue == null;
    const has2chars = typeof newValue === 'string' && newValue.length >= 2;
    if (isBlank) { throw new Error('name: required') };
    if (!has2chars) { throw new Error('name: has2chars') };
  }
}
```
