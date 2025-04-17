import type { Application } from 'express'
import swaggerJSDoc from 'swagger-jsdoc'
import swaggerUi from 'swagger-ui-express'


const swaggerOptions = {
  swaggerDefinition: {
    openapi: '3.0.0',
    info: {
      title: 'API Documentation',
      version: '1.0.0',
      description: 'API Documentation',
    },
  },
  apis: ['src/handler/*.ts'], // Path to the API routes files
}

const swaggerSpec = swaggerJSDoc(swaggerOptions)

export function SwaggerSetup(app: Application) {
  app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec))
}