import { lazy } from 'react';

const FormUpload = lazy(() => import('../pages/Form/FormUpload'));
const SendResponse = lazy(() => import('../pages/Form/FormResponse'));
const Settings = lazy(() => import('../pages/Settings'));
const DataManagement = lazy(() => import('../pages/DataManagement'));
const DataResponse = lazy(() => import('../pages/DataResponse'));

const coreRoutes = [
  {
    path: '/data-management',
    title: 'Data Management',
    component: DataManagement,
  },
  {
    path: '/data-response',
    title: 'Data Response',
    component: DataResponse,
  },
  {
    path: '/data-management/create',
    title: 'Form Upload',
    component: FormUpload,
  },
  {
    path: '/data-response/send',
    title: 'Send Response',
    component: SendResponse,
  },
  {
    path: '/settings',
    title: 'Settings',
    component: Settings,
  },
  {
    path: '/data-management/upload-pdf',
  },
  {
    path: '/data-management/upload-news',
  },
  {
    path: '/data-management/upload-text',
  },
];

const routes = [...coreRoutes];
export default routes;
