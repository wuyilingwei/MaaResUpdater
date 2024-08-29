// 镜像站是否开启 HTTPS.
const https = true;

// 屏蔽国家和地区.
const blocked_region = [];

// 屏蔽 IP 地址.
const blocked_ip_address = ['0.0.0.0', '127.0.0.1'];

// 固定的下载 URL
const fixed_url = 'https://github.com/MaaAssistantArknights/MaaResource/archive/refs/heads/main.zip';

addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})

async function fetchAndApply(request) {
    const region = request.headers.get('cf-ipcountry').toUpperCase();
    const ip_address = request.headers.get('cf-connecting-ip');

    if (blocked_region.includes(region)) {
        return new Response('Access denied: Not available in your region yet.', {
            status: 403
        });
    }

    if (blocked_ip_address.includes(ip_address)) {
        return new Response('Access denied: IP address is blocked.', {
            status: 403
        });
    }

    // 创建新的请求，指向固定的 URL
    let new_request_headers = new Headers(request.headers);
    new_request_headers.set('Host', 'github.com');
    new_request_headers.set('Referer', 'github.com');

    let response = await fetch(fixed_url, {
        method: request.method,
        headers: new_request_headers
    });

    let new_response_headers = new Headers(response.headers);
    new_response_headers.set('access-control-allow-origin', '*');
    new_response_headers.set('access-control-allow-credentials', true);
    new_response_headers.delete('content-security-policy');
    new_response_headers.delete('content-security-policy-report-only');
    new_response_headers.delete('clear-site-data');

    return new Response(response.body, {
        status: response.status,
        headers: new_response_headers
    });
}
