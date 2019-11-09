# VUE
为了在Vue应用程序中使用自定义元素库，必须修改应用程序以定义自定义元素并通知Vue编译器编译期间要忽略哪些元素。这都可以在main.js文件中完成。

假设您已经运行了npm install——save test-components ，并且test-component 是我们发布给npm的组合Web组件的名称，那么您可以通过
 - 'import' 导入到 main.js
 - 告诉Vue忽略自定义元素标记[（请参阅https://vuejs.org/v2/api/#ignoredElements）](https://vuejs.org/v2/api/#ignoredElements)
 - 将Stenciljs组件代码绑定到窗口对象

```
import Vue from 'vue';
import App from './App.vue';

import { applyPolyfills, defineCustomElements } from 'test-components/dist/loader';

Vue.config.productionTip = false;

// Tell Vue to ignore all components defined in the test-components
// package. The regex assumes all components names are prefixed
// 'test'
Vue.config.ignoredElements = [/test-\w*/];

// Bind the custom elements to the window object
applyPolyfills().then(() => {
  defineCustomElements(window);
});

new Vue({
  render: h => h(App)
}).$mount('#app');
```
这些组件应该可以在任何Vue组件中使用
```
render() {
  return (
    <div>
      <test-stencil-component></test-stencil-component>
    </div>
  )
}
```
Vue提供了几种在应用程序中安装和使用框架的不同方法。上述用于集成模具自定义元素库的技术已在Vue应用程序上进行了测试，该应用程序是使用以ES2015和WebPack为主要选项的Vue cli创建的。如果应用程序是使用其他选项生成的，则应该使用类似的技术。