const isTestEnv = () => currentEnv() === 'test'

const isDevelopmentEnv = () => currentEnv() === 'development'

const isProductionEnv = () => currentEnv() === 'production'

const currentEnv = () => document.head.querySelector('meta[name=environment]').content

export { isTestEnv, isDevelopmentEnv, isProductionEnv }
