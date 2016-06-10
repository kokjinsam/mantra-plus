# Mantra Plus

Core API with extras for Mantra.

## Introduction

This repo contains the core APP api where we create an mantra app and initialize it. Also, this package contains exported functions from [`react-simple-di`](https://github.com/kadirahq/react-simple-di). The best thing is Mantra Plus supports middlewares! Now you don't have to rewrite, copy and paste your context.

## Installation

```
npm i --save mantra-plus react
```


## Basic Usage

```
import MyComp from './myComp';
import { createApp } from 'mantra-plus';
import redux from './redux-middleware';

// Here's a simple Mantra Module
const module = {
  routes(injectDeps) {
    const InjectedComp = injectDeps(MyComp);
    // load routes and put `InjectedComp` to the screen.
  },
  load(context, actions) {
    // do any module initialization
  },
  actions: {
    myNamespace: {
      doSomething: (context, arg1) => {}
    }
  }
};

const context = {
  client: new DataClient()
};

const app = createApp(context);

// middlewares must be loaded before loading module
app.loadMiddlewares([redux]);
app.loadModule(module);
app.loadModule(someOtherModule);
app.init();
```

## Middlewares

- [`mantra-redux`](https://github.com/sammkj/mantra-redux) Add Redux to your app
- [`mantra-apollo`](https://github.com/sammkj/mantra-apollo) Add Apollo to your app

## Writing a Middleware

Middleware must return an object that contains any of `moduleWillLoad`, `moduleWillInit`. Below code is available on NPM (`mantra-redux`).

```
function reduxMiddleware(options) {
  const {
    reducers = {},
    middlewares = [],
    storeName = 'Store',
  } = options;

  return {
    moduleWillLoad(module, context) {
      if (module.reducers) {
        if (typeof reducers !== 'object' || typeof module.reducers !== 'object') {
          const message = "Module's reducers field should be a map of reducers.";
          throw new Error(message);
        }

        const allReducers = {
          ...module.reducers,
          ...reducers,
        };

        this._reducers = allReducers;
      }
    },
    moduleWillInit() {
      const reduxStore = createReduxStore({
        reducers: this._reducers,
        middlewares,
      });

      this.context[storeName] = reduxStore;
      this.context.dispatch = reduxStore.dispatch;
    },
  };
}
```
