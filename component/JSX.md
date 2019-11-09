# JSX
Stencli组件使用JSX（一种流行的声明性模板语法）呈现。每个组件都有一个呈现函数，该函数返回在运行时呈现给DOM的组件树。
##### Basics
render函数用于输出将绘制到屏幕的组件树。
```
class MyComponent {
  render() {
    return (
      <div>
        <h1>Hello World</h1>
        <p>This is JSX!</p>
      </div>
    );
  }
}
```
##### Host Element 宿主元素
如果要修改宿主元素本身，例如向组件本身添加类或属性，请使用<host>函数组件。[查看此处的详细信息]
##### 数据绑定
组件通常需要呈现动态数据。要在JSX中执行此操作，请在变量周围使用花括号{}：
```
render() {
  return (
    <div>Hello {this.name}</div>
  )
}
```
也可使使用es6模板字符串
```
//ES6
`Hello ${this.name}`

//JSX
Hello {this.name}s
```
##### 条件渲染
使用if else 语句
```
render() {
  if (this.name) {
    return ( <div>Hello {this.name}</div> )
  } else {
    return ( <div>Hello, World</div> )
  }
}
```
使用三元运算
```
{someCondition
  ? <my-counter initialValue={2} />
  : <my-counter initialValue={5} />
}
```
如果要在条件中销毁和重新创建组件，可以指定key属性。这告诉组件实际上是不同的同级：
```
{someCondition
  ? <my-counter key="a" initialValue={2} />
  : <my-counter key="b" initialValue={5} />
}
```
##### Slots 插槽
组件通常需要在其组件树的特定位置呈现动态子组件，允许开发人员在使用我们的组件时提供子内容，而我们的组件将该子组件放置在正确的位置。
```
// my-component.tsx

render() {
  return (
    <div>
      <h2>A Component</h2>
      <div><slot /></div>
    </div>
  );
}
```
如果用户在创建组件my component时传递子组件，则my component会将该组件放置在上面的第二个div中：
```
render(){
  return(
    <my-component>
      <p>Child Element</p>
    </my-component>
  )
}
```
插槽也可以有允许指定插槽输出位置的名称
```
// my-component.tsx

render(){
  return [
    <slot name="item-start" />,
    <h1>Here is my main content</h1>,
    <slot name="item-end" />
  ]
}
```
```
render(){
  return(
    <my-component>
      <p slot="item-start">I'll be placed before the h1</p>
      <p slot="item-end">I'll be placed after the h1</p>
    </my-component>
  )
}
```
###### 循环
在创建JSX树时，可以使用传统的循环在JSX中创建循环，或者在现有JSX中内联时使用诸如MAP之类的数组运算符。

在下面的例子中，我们假设组件有一个名为todo的本地属性，它是todo对象的列表。我们将使用数组中的map函数循环映射中的每个项，并将其转换为其他内容-在本例中是JSX。
```
render() {
  return (
    <div>
      {this.todos.map((todo) =>
        <div>
          <div>{todo.taskName}</div>
          <div>{todo.isCompleted}</div>
        </div>
      )}
    </div>
  )
}
```
map函数的每个步骤都会创建一个新的JSX子树，并将其添加到从map返回的数组中，然后将其绘制在上面的JSX树中。

如果您的列表是动态的，也就是说，可以更改、添加、删除或重新排序项，那么您应该为每个元素分配一个唯一的键，以使其具有稳定的标识。这使得模具可以重用DOM元素以获得更好的性能。选择键的最佳方法是使用一个字符串，该字符串在其兄弟项中唯一地标识该列表项（通常您的数据已经具有id）
```
render() {
  return (
    <div>
      {this.todos.map((todo) =>
        <div key={todo.uid}>
          <div>{todo.taskName}</div>
          <div>{todo.isCompleted}</div>
          <button onClick={() => this.remove(todo)}>X</button>
        </div>
      )}
    </div>
  )
}
```
数组中使用的键在其同级中应该是唯一的。然而，它们不需要是全局唯一的。
#####  处理用户输入
使用原生DOM事件
```
export class MyComponent {
  handleClick(event: UIEvent) {
    alert('Received the button click!');
  }

  render() {
    return (
      <button onClick={ (event: UIEvent) => this.handleClick(event)}>Click Me!</button>
    );
  }
}
```
另一种方法是使用以下语法：
```
handleClick(event: UIEvent) {
    alert('Received the button click!');
  }

  render() {
    return (
      <button onClick={this.handleClick.bind(this)}>Click Me!</button>
    );
  }
```
下面是监听chang事件的另一个示例。注意箭头功能的使用。
```
export class MyComponent {
  inputChanged(event) {
    console.log('input changed: ', event.target.value);
  }

  render() {
    return (
      <input onChange={(event: UIEvent) => this.inputChanged(event)}>
    );
  }
}
```
##### 复杂模板内容
到目前为止，我们已经看到了如何只返回一个根元素的示例。我们还可以在根元素中嵌套元素

如果一个组件有多个“顶级”元素，render函数可以返回一个数组。注意div元素之间的逗号
```
render() {
  return ([
  // first top level element
  <div class="container">
    <ul>
      <li>Item 1</li>
      <li>Item 2</li>
      <li>Item 3</li>
    </ul>
  </div>,

  // second top level element, note the , above
  <div class="another-container">
    ... more html content ...
  </div>
  ]);
}
```
也可以使用innerHTML将内容直接内联到元素中。例如，当动态加载svg，然后希望将其呈现在div中时，这会很有帮助。它的工作方式与在普通HTML中一样：
```
<div innerHTML={svgContent}></div>
```
##### 获取对DOM元素的引用
在需要获得对元素的直接引用的情况下，就像通常使用document.querySelector一样，您可能希望在JSX中使用ref。让我们看一个在表单中使用ref的示例：
 ```
 @Component({
  tag: 'app-home',
})
export class AppHome {

  textInput!: HTMLInputElement;

  handleSubmit = (ev: Event) => {
    ev.preventDefault();
    console.log(this.textInput.value);
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Name:
          <input type="text" ref={(el) => this.textInput = el as HTMLInputElement} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}
 ```
 在本例中，我们使用ref获取对输入ref={（el）=>this.textInput=el的引用，作为HTMLInputElement}。然后，我们可以使用该ref执行一些操作，例如直接从文本输入this.text input.value中获取值。
##### 避免共享JSX节点
渲染器缓存元素查找以提高性能。但是，这样做的一个副作用是，不应该在同一个呈现器中共享完全相同的JSX节点。

在下面的示例中，在render（）函数中多次重用sharedNode变量。渲染器可以通过缓存引用来优化其DOM元素查找，但是，这会导致在重用节点时出现问题。相反，建议始终生成唯一节点，如下面更改的示例。
```
@Component({
  tag: 'my-cmp',
})
export class MyCmp {

  render() {
-    const sharedNode = <div>Text</div>;
    return (
      <div>
-        {sharedNode}
-        {sharedNode}
+        <div>Text</div>
+        <div>Text</div>
      </div>
    );
  }
}
```
或者，可以使用创建工厂函数来返回公共JSX节点，因为返回的值将是唯一的实例。例如：
```
@Component({
  tag: 'my-cmp',
})
export class MyCmp {

  getText() {
    return <div>Text</div>;
  }

  render() {
    return (
      <div>
        {this.getText()}
        {this.getText()}
      </div>
    );
  }
}
```
