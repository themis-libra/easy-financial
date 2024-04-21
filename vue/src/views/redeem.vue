<template>
    <div class="purchase">
        <el-card class="hours" v-if="buyState === 0">
            <div style="text-align: center">
                <img src="../assets/hours.png">
            </div>
        </el-card>
        <el-card class="purchase_card"  v-else-if="buyState === 1">
            <div class="card_header">产品赎回</div>
            <el-divider></el-divider>
            <div class="card_input">
                <div class="input_item">
                    <span>账号输入</span>
                    <el-input placeholder="请输入账号" v-model="userAccount" class="input">
                        <el-button slot="append" icon="el-icon-search" @click="searchCid"></el-button>
                    </el-input>
                </div>
            </div>
            <el-card class="user_info" shadow="hover" style="margin-top: 30px">
                <div style="font-weight: bold">客户信息</div>
                <div class="info_item">客户名称：{{ this.userInfo.cname }}</div>
                <div class="info_item">客户类型：{{ this.userInfo.ctype }}</div>
                <div class="id_div">
                    <div class="info_item">证件类型：{{ this.userInfo.idtype }}</div>
                    <div class="info_item">证件号码：{{ this.userInfo.cid }}</div>
                </div>
                <div class="info_item">风险等级：{{ this.userInfo.clevel }}</div>
            </el-card>
            <div class="business_info">
                <div class="info_header">业务信息</div>
                <div class="info_content">
                    <div class="input_item">
                        <span>产品代码</span>
                        <el-input placeholder="请输入产品代码" v-model="businessInfo.rpid" class="input"></el-input>
                    </div>
                    <div class="bank_card_item" style="display: flex">
                        <div class="input_item">
                            <span>资金方式</span>
                            <el-select placeholder="请选择资金方式" v-model="businessInfo.rbankcardNumber" class="input" style="width: 400px">
                                <el-option
                                    v-for="item in wayOptions"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                                </el-option>
                            </el-select>
                        </div>
                    </div>
                    <div class="input_item">
                        <span>赎回份额</span>
                        <el-input placeholder="请输入赎回份额" v-model="businessInfo.rshare" class="input" style="width: 400px"></el-input>
                        <div class="input_item" style="margin-left: 355px">
                            <span>可用份额：{{ this.share }}</span>
                        </div>
                    </div>
                    <div class="add_button" style="margin-left: 43%; margin-top: 20px">
                        <el-button type="primary" icon="el-icon-circle-plus-outline" @click="confirmRedeem">确认赎回</el-button>
                    </div>
                </div>
            </div>
        </el-card>
        <el-card class="purchase_success" v-else-if="buyState === 2">
            <div class="success">
                <img src="../assets/success1.png">
                <div class="success_info">赎回成功！</div>
                <div class="info_name">投资人名称：{{ this.businessInfo.rcname }}</div>
                <div class="info_name">交易账号：{{this.userAccount}}</div>
                <div class="business_info">
                    <div class="business_pro">
                        <span style="font-weight: bold; font-size: 18px">产品信息</span>
                        <span>{{ this.businessInfo.rpid }}</span>
                    </div>
                    <div class="business_count">
                        <span style="font-weight: bold; font-size: 18px">赎回份额</span>
                        <span>{{ this.businessInfo.rshare }}</span>   
                    </div>
                </div>
                <div class="button">
                    <el-button type="primary" @click="()=>{this.$router.push({name: 'RedeemSearch'})}">赎回详情</el-button>
                    <el-button @click="()=>{this.buyState = 1}">完成</el-button>
                    <el-button @click="()=>{this.$router.push({name: 'Home'})}">返回首页</el-button>
                </div>
            </div>
        </el-card>
    </div>
</template>

<script>
import axios from '../http/request'
export default {
    name: 'Purchase',
    data () {
        return {
            userAccount: '',
            userInfo: {
                cname: '',
                ctype: '',
                idtype: '',
                cid: '',
                clevel: ''
            },
            proInfo: {
                pid: '',
                pname: '',
                ptype: '',
                plevel: '',
                pstate: '',
                ptime: '',
                deleted: ''
            },
            businessInfo: {
                rcname: '',
                rcid: '',
                rpid: '',
                ramount: 0,
                rbankcardNumber: '',
                rshare: ''
            },
            share: 1,
            wayOptions: [],
            buyState: 1, // 0表示当前不在赎回时间 1表示在赎回界面 2表示赎回成功界面
        }
    },
    methods: {
        confirmRedeem() {
            this.businessInfo.rcname = this.userInfo.cname
            this.businessInfo.rcid = this.userInfo.cid
            console.log(this.businessInfo);
            axios.post('http://127.0.0.1:8080/redemption/redeem', this.businessInfo)
                .then(res => {
                    if (res.code === 200) {
                        this.$message.success("赎回产品成功")
                        this.buyState = 2
                    }
                })
        },
        searchCid() {
            axios.post(`http://127.0.0.1:8080/customer/getUserInfo/${this.userAccount}`)
                .then(res => {
                    if (res.code === 200) {
                        this.userInfo.cname = res.data.cname
                        this.userInfo.ctype = res.data.ctype
                        this.userInfo.idtype = res.data.idtype
                        this.userInfo.cid = res.data.cid
                        this.userInfo.clevel = res.data.clevel
                        this.wayOptions = res.data.cardList.map(x => {
                            return {
                                value: x,
                                label: x
                            }
                        })
                        this.$message.success("查询客户成功")
                    }
                })
        },
        getShare(rpid, rbankcardNumber) {
            axios.post(`http://127.0.0.1:8080/subscribe/getShare/${rpid}/${rbankcardNumber}`)
                .then(res => {
                    if (res.code === 200) {
                        this.share = res.data
                        console.log(this.share);
                    }
                })
        },
        isShutDown() {
            axios.get('http://127.0.0.1:8080/systemState/shutdown')
                .then(res => {
                    if (res.code === 200) {
                        if (res.data.msg === "停止交易") {
                            this.buyState = 0
                        }
                    }
                })
        }
    },
    mounted() {
        if (this.buyState === 0) {
            this.$message({
                type: 'error',
                message: '当前不在营业时间！',
                duration: 4000
            })
        }
    },
    watch: {
        'businessInfo.rpid': {
            handler: function(newVal, oldVal) {
                this.getShare(newVal, this.businessInfo.rbankcardNumber)
            }
        },
        'businessInfo.rbankcardNumber': {
            handler: function(newVal, oldVal) {
                this.getShare(this.businessInfo.rpid, newVal)
            }
        },
    }
}
</script>

<style lang="less" scoped>
.purchase {
    .purchase_card {
        .card_header {
            font-size: 18px;
            font-weight: bold;
        }
        .card_input {
            .input_item {
                margin: 0 auto;
                display: flex;
                align-items: center;
                .input {
                    margin-left: 30px;
                    width: 400px;
                }
            }
        }
        .user_info {
            .id_div {
                display: flex;
            }
            .info_item {
                width: 45%;
                margin-top: 20px;
            }
        }
        .business_info {
            margin-top: 20px;
            .info_header {
                font-size: 16px;
                font-weight: bold;
            }
            .info_content {
                margin-top: 20px;
                .input_item {
                    margin-bottom: 20px;
                    display: flex;
                    align-items: center;
                    .input {
                        margin-left: 30px;
                        width: 80%;
                    }
                }
            }
        }
    }
    .purchase_success {
        .success {
            margin: 0 auto;
            text-align: center;
            img {
                width: 160px;
                height: 150px;
            }
            .success_info {
                margin-top: 10px;
                font-size: 22px;
                margin-bottom: 10px;
            }
            .business_info {
                display: flex;
                justify-content: center;
                margin-top: 30px;
                div {
                    margin-right: 10px;
                    line-height: 40px;
                    width: 250px;
                    height: 100px;
                    background-color: rgb(212, 212, 212);
                    display: flex;
                    flex-direction: column;
                }
            }
            .button {
                margin-top: 50px;
            }
        }
    }
}
</style>