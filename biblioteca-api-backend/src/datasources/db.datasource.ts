import {inject, lifeCycleObserver, LifeCycleObserver} from '@loopback/core';
import {juggler} from '@loopback/repository';

const config = {
  name: 'db',
  connector: 'mysql',
  host: process.env.DB_HOST || 'biblioteca-database',
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '1f18ac3cd637',
  database: process.env.DB_DATABASE || 'biblioteca_m3_recurso',
  authPlugin: 'mysql_native_password',
  charset: 'utf8mb4'
};

@lifeCycleObserver('datasource')
export class DbDataSource extends juggler.DataSource
 implements LifeCycleObserver {
 static dataSourceName = 'db';
 static readonly defaultConfig = config;

 constructor(
   @inject('datasources.config.db', {optional: true})
   dsConfig: object = config,
 ) {
   super(dsConfig);
 }
}
