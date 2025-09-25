// vite.config.js
import { defineConfig } from 'vite';

export default defineConfig({
  server: {
    allowedHosts: [
      'localhost',
      '127.0.0.1',
      'strapi-alb-mayank-1012566506.ap-south-1.elb.amazonaws.com'
    ]
  }
});