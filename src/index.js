import { useDeps } from 'react-simple-di';
import App from './app';

const createApp = (...args) => (new App(...args));

export {
  createApp,
  useDeps,
};
