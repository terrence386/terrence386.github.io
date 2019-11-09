# REACT
对于使用create react app脚本构建的应用程序，包含组件库的最简单方法是从index.js文件调用definecustomements（window）。注意，在这个场景中，如果您的目标是Edge或IE11，则需要applyPolyfills。
```
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';

// test-component is the name of our made up Web Component that we have
// published to npm:
import { applyPolyfills, defineCustomElements } from 'test-components/dist/loader';

ReactDOM.render(<App />, document.getElementById('root'));
registerServiceWorker();

applyPolyfills().then(() => {
  defineCustomElements(window);
});
```
遵循上面的步骤将使您的Web组件在react中被使用，但是也有一些额外的复杂性必须被考虑。[https://custom-elements-everywhere.com/](https://custom-elements-everywhere.com/)很好地描述了它们。