# Angular
在Angular CLI项目中使用Stencil构建的web组件集合是一个两步过程。我们需要：

1.在使用组件的模块中引入`CUSTOM_ELEMENTS_SCHEMA`。

2.从main.ts（或其他适当的位置）调用`defineCustomElements(window)`。

##### 引入 `CUSTOM_ELEMENTS_SCHEMA`
`CUSTOM_ELEMENTS_SCHEMA`允许在HTML标记中使用web组件，而编译器不会产生错误。此代码应添加到AppModule和使用自定义元素的所有其他模块中。

下面是将其添加到AppModule的示例：
```
import { BrowserModule } from '@angular/platform-browser';
import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';

@NgModule({
  declarations: [AppComponent],
  imports: [BrowserModule, FormsModule],
  bootstrap: [AppComponent],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
})
export class AppModule {}
```
##### 调用 `defineCustomElements(window)`
使用Stencil构建的组件集合包含用于加载集合中组件的主函数。该函数称为definecustomements（），在应用程序引导期间需要调用一次。
这样做的一个方便的地方是main.ts：
```
import { enableProdMode } from '@angular/core';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';
import { environment } from './environments/environment';

// Note: loader import location set using "esmLoaderPath" within the output target confg
import { defineCustomElements } from 'test-components/dist/loader';

if (environment.production) {
  enableProdMode();
}

platformBrowserDynamic().bootstrapModule(AppModule)
  .catch(err => console.log(err));
defineCustomElements(window);
```
##### Edge and IE11 polyfillss
如果希望自定义元素能够在较旧的浏览器上工作，则应在definecustomements（）函数的周围添加applyPolyfills（）。
```
import { applyPolyfills, defineCustomElements } from 'test-components/loader';
...
applyPolyfills().then(() => {
  defineCustomElements(window)
})
```
##### 使用ViewChild和ViewChildren访问组件
引入后，可以在代码中使用ViewChild和ViewChildren引用组件，如下例所示：
```
import {Component, ElementRef, ViewChild} from '@angular/core';

import 'test-components';

@Component({
    selector: 'app-home',
    template: `<test-components #test></test-components>`,
    styleUrls: ['./home.component.scss'],
})
export class HomeComponent {

    @ViewChild('test') myTestComponent: ElementRef<HTMLTestComponentElement>;

    async onAction() {
        await this.myTestComponent.nativeElement.testComponentMethod();
    }
}
```
