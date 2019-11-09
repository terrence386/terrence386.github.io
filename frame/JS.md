# 不使用框架
如果您使用的是简单的HTML页面，则可以通过脚本标记添加组件。例如，如果我们将组件发布到npm，我们可以通过unpkg加载组件，如下所示：
```
<!DOCTYPE html>
<html lang="en">
<head>
  <script src="https://unpkg.com/test-components/latest/dist/test-components.js"></script>
</head>
<body>
  <test-component></test-component>
</body>
</html>
```
或者，如果您想利用ES模块，可以使用import语句包含组件。注意，在这个场景中，如果您的目标是Edge或IE11，则需要applyPolyfills。
```
<!DOCTYPE html>
<html lang="en">
<head>
  <script type="module">
    import { applyPolyfills, defineCustomElements } from 'https://unpkg.com/test-components/loader';
    applyPolyfills().then(() => {
      defineCustomElements(window);
    });
  </script>
</head>
<body>
  <test-component></test-component>
</body>
</html>
```
##### Passing object props from a non-JSX element 
非 JSX 原素传递props
##### 手动设置prop
```
import { Prop } from '@stencil/core';

export class TodoList {
  @Prop() myObject: object;
  @Prop() myArray: Array<string>;
}
```
```
<todo-list></todo-list>
<script>
  const todoListElement = document.querySelector('todo-list');
  todoListElement.myObject = {};
  todoListElement.myArray = [];
</script>
```
##### 监听props 变化
```
import { Prop, State, Watch } from '@stencil/core';

export class TodoList {
  @Prop() myObject: string;
  @Prop() myArray: string;
  @State() myInnerObject: object;
  @State() myInnerArray: Array<string>;

  componentWillLoad() {
    this.parseMyObjectProp(this.myObject);
    this.parseMyArrayProp(this.myArray);
  }

  @Watch('myObject')
  parseMyObjectProp(newValue: string) {
    if (newValue) this.myInnerObject = JSON.parse(newValue);
  }

  @Watch('myArray')
  parseMyArrayProp(newValue: string) {
    if (newValue) this.myInnerArray = JSON.parse(newValue);
  }
}
```
```
<todo-list my-object="{}" my-array="[]"></todo-list>
```