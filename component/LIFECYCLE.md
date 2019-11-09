# 组件生命周期
组件有许多生命周期方法，可用于知道组件何时更新和卸载。这些方法可以添加到组件中，以便在正确的时间挂接到操作中。

在组件类中实现以下方法之一，Stencli将自动按正确顺序调用它们：
##### connectedCallback()
每次组件连接到DOM时调用。当组件第一次连接时，在组件加载之前调用此方法。

需要注意的是，每次在DOM中附加或移动元素时，都可以多次调用此方法。
```
const el = document.createElement('my-cmp');
document.body.appendChild(el);
// connectedCallback() called
// componentWillLoad() called (first time)

el.remove();
// disconnectedCallback()

document.body.appendChild(el);
// connectedCallback() called again, but `componentWillLoad` is not.
```
##### disconnectedCallback()
每次组件与DOM断开连接时调用，即，它调用被多次分派，不要与“onDestroy”类型的事件混淆。
##### componentWillLoad()
在组件第一次连接到DOM之后调用一次。可以返回一个promise，该promise可用于等待第一次渲染。
##### componentDidLoad()
在组件完全加载且第一渲染render（）发生后调用一次。
##### componentWillRender()
Called before every render().

A promise can be returned, that can be used to wait for the upcoming render.
##### componentDidRender()
每次渲染后调用 render()
##### componentWillUpdate()
组件将要更新时调用, Prop() or State() 变化时调用
##### componentDidUpdate()
组件更新后调用
##### Rendering State
始终建议在componentWillLoad（）或componentWillUpdate（）中进行任何呈现状态更新，因为这些是在render（）方法之前调用的方法。或者，使用componentDidLoad（）或componentdiddupdate（）方法更新呈现状态将导致另一次重新呈现，这对于性能来说并不理想。

如果必须在componentDidUpdate（）中更新状态，则可能会使组件陷入无限循环中。如果在componentDidUpdate（）中更新状态是不可避免的，那么该方法还应该提供一种方法来检测道具或状态是否“脏”（数据是否实际不同或与以前相同）。通过执行脏检查，componentDidUpdate（）能够避免呈现相同的数据，而这些数据又会再次调用componentDidUpdate（）。
##### Lifecycle Hierarchy 层次
生命周期方法的一个有用特性是，它们也会考虑子组件的生命周期。例如，如果父组件cmp-a具有子组件cmp-b，则在cmp-b完成加载之前，不会将cmp-a视为“已加载”。另一种说法是，最深的组件首先完成加载，然后componentDidLoad（）调用bubble up。

还需要注意的是，尽管Stencil可以延迟加载组件，并具有异步呈现，但生命周期方法仍然以正确的顺序调用。因此，虽然顶级组件可能已经加载，但其所有生命周期方法仍按正确的顺序调用，这意味着它将等待子组件完成加载。完全相反的情况也是如此，子组件可能已经准备好了，而父组件却没有准备好。

在下面的示例中，我们有一个简单的组件层次结构。编号的列表显示生命周期方法将启动的顺序。
```
<cmp-a>
    <cmp-b>
      <cmp-c></cmp-c>
    </cmp-b>
  </cmp-a>
```
```
1.cmp-a - componentWillLoad()
2.cmp-b - componentWillLoad()
3.cmp-c - componentWillLoad()
4.cmp-c - componentDidLoad()
5.cmp-b - componentDidLoad()
6.cmp-a - componentDidLoad()
```
即使某些组件可能已加载，也可能尚未加载，整个组件层次结构仍会等待其子组件完成加载和呈现。
##### Async Lifecycle Methods 异步生命周期方法
生命周期方法还可以返回允许方法异步检索数据或执行任何异步任务的承诺。一个很好的例子是获取要在组件中呈现的数据。例如，您正在阅读的这个站点在呈现之前首先获取内容数据。但由于fetch（）是异步的，所以componentWillLoad（）返回一个承诺，以确保在其所有内容呈现之前，不会将其父组件视为“已加载”。

下面是一个快速示例，显示componentWillLoad（）如何让其父组件等待它完成数据加载。
```
componentWillLoad() {
  return fetch('/some-data.json')
    .then(response => response.json())
    .then(data => {
      this.content = data;
    });
}
```
##### 示例
这个简单的例子显示了一个时钟并每秒更新当前时间。由于componentDidLoad只调用一次，因此我们将只运行计时器的一个实例。组件卸载后，计时器将停止。
```
import { Component, State, h } from '@stencil/core';

@Component({
  tag: 'custom-clock'
})
export class CustomClock {

  timer: number;

  @State() time: number = Date.now();

  componentDidLoad() {
    this.timer = window.setInterval(() => {
      this.time = Date.now();
    }, 1000);
  }

  componentDidUnload() {
    window.clearInterval(this.timer);
  }

  render() {
    const time = new Date(this.time).toLocaleTimeString();

    return (
      <span>{ time }</span>
    );
  }
}
```