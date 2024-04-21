module.exports = {
    devServer: {
        // 1.指定服务的ip
        host: "127.0.0.1",
        // 2.指定服务的端口
        port: 8080,
        open: true,
        overlay: {
            warnings: false,
            errors: true
        },
        // 3.开发环境进行http的代理
        proxy: {
        // 匹配 url 路径的开头
            '/': {
            // 1.路劲只要是/api开头的url都代理到下面这个网站。
            // 例如：'/api[表情]xx' 会代理到 https://119.20.224.137/api/xxxx
            target: 'http://127.0.0.1:8080',
            changeOrigin: true,
            pathRewrite: {
                '^/api': '/api'
                }
            }
        }
    },
}
