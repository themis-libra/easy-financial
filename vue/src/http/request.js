import axios from "axios";  //����axios
import env from "./env"; 

// ����axiosʵ��
const service = axios.create({
	//���������Ͻӿڲ���
	// baseUrl: "http://127.0.0.1:8080/",
    headers:{ //����ͷ
        'Content-Type': 'application/json;charset=UTF-8',
    },
    settimeout:50000,//��ʱʱ��
});
// ����������
service.interceptors.request.use(
    config => {
        if (localStorage.getItem('token')) {
            config.headers.token = localStorage.getItem('token')
        }
        return config;
    },
    error => {
        return Promise.reject(error);
    }
);
    
// ��Ӧ������
service.interceptors.response.use(
    response => {
        if (response.status && response.status === 200) {
            // ͨѶ�ɹ�
            if (response.data.code === 0) {
                return response.data
            }
            return Promise.resolve(response.data)
        }
    },
    error => {
        // ����Ӧ��������ʲô
        return Promise.reject(error);
    }
);
export default service;
