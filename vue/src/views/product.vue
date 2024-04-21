<template>
  <div class="product">
    <div class="search_container">
      <div class="search_item">
        <el-select v-model="search_content.search_type" placeholder="请选择">
          <el-option
            v-for="item in searchTypeOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value">
          </el-option>
        </el-select>
      </div>
      <div class="search_item">
        <el-input v-model="search_content.search_value" placeholder="请输入"></el-input>
      </div>
      <div class="search_button">
        <el-button type="primary" @click="search">搜索</el-button>
        <el-button @click="reset">重置</el-button>
      </div>
    </div>
    <div class="add_button">
      <el-button type="primary" @click="addSingleProduct">添加单个产品</el-button>
      <el-button type="primary" @click="massAddProducts">批量添加产品</el-button>
      <download-excel
        class="export-excel-wrapper"
        :data="tableData"
        :fields="json_fields1"
        name="产品信息.xls"
      >
        <el-button icon="el-icon-download" type="success">导出</el-button>
      </download-excel>
    </div>
    <el-table :data="tableData" border style="width: 100%" middle>
      <el-table-column prop="pid" label="产品代码" align="center">
      </el-table-column>
      <el-table-column prop="pname" label="产品名称" align="center">
      </el-table-column>
      <el-table-column prop="ptype" label="产品类型" align="center" :filters="type_filter" :filter-method="type_fil">
      </el-table-column>
      <el-table-column prop="plevel" label="产品风险等级" align="center">
      </el-table-column>
      <el-table-column prop="pstate" label="产品状态" align="center">
      </el-table-column>
      <el-table-column
        prop="ptime"
        label="产品创建或修改时间"
        align="center"
      ></el-table-column>
      <el-table-column label="操作" align="center" width="230">
        <template slot-scope="scope">
          <el-button type="success" size="mini" @click="handleShow(scope.$index, scope.row)"
            >查看</el-button
          >
          <el-button type="primary" size="mini" @click="handleEdit(scope.$index, scope.row)"
            >编辑</el-button
          >
          <el-button type="danger" size="mini" @click="handleDelete(scope.$index, scope.row)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <el-dialog
      title="净值走向"
      @open="open()"
      :visible.sync="dialogVisible"
      width="75%"
      :before-close="handleClose"
    >
      <div class="content" style="display: flex;">
        <el-tabs type="border-card" style="width: 55%; margin-right: 20px">
          <el-tab-pane label="单位净值走势">
            <div id="myChart" style="width: 600px; height: 500px;"></div>
          </el-tab-pane>
          <el-tab-pane label="日增长率走势">
            <div id="myChart2" style="width: 600px; height: 500px;"></div>
          </el-tab-pane>
        </el-tabs>
        <el-tabs type="border-card" style="width: 42%;">
          <el-tab-pane label="净值">
            <el-table
              :data="proMarket"
              stripe
              style="width: 100%">
              <el-table-column
                prop="mtime"
                align="center"
                label="日期">
              </el-table-column>
              <el-table-column
                prop="netValue"
                align="center"
                label="单位净值">
              </el-table-column>
              <el-table-column
                prop="dailyGrowthRate"
                align="center"
                label="日增长率">
                <template slot-scope="scope">
                  <el-tag
                    :type="scope.row.dailyGrowthRate > 0 ? 'success' : 'danger'"
                    disable-transitions>{{scope.row.dailyGrowthRate + "%"}}
                  </el-tag>
                </template>
              </el-table-column>
            </el-table>
          </el-tab-pane>
        </el-tabs>
      </div>
    </el-dialog>
    <el-dialog :title="operateType === 'add' ? '新增产品' : '编辑产品'" :visible.sync="add_editVisible" :before-close="cancelAdd_Edit">
      <el-form :model="add_editContent">
        <el-form-item>
          产品代码：
          <el-input v-model="add_editContent.pid"></el-input>
        </el-form-item>
        <el-form-item>
          产品名称：
          <el-input v-model="add_editContent.pname"></el-input>
        </el-form-item>
        <el-form-item>
          产品类型：
          <el-select v-model="add_editContent.ptype">
            <el-option
              v-for="item in typeOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          风险等级：
          <el-select v-model="add_editContent.plevel">
            <el-option
              v-for="item in levelOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          产品状态：
          <el-select v-model="add_editContent.pstate">
            <el-option
              v-for="item in stateOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancelAdd_Edit">取 消</el-button>
        <el-button type="primary" @click="addSingleConfirm">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog
      title="产品信息批量导入"
      :visible.sync="mass_addVisible"
      width="60%"
      :before-close="handleMassClose"
    >
      <div class="boxTitle">
        <span class="warninger" style="color: red;">上传文件后缀必须是(xls)，且根据模板上传，否则不能上传成功</span>
        <download-excel
          class="export-excel-wrapper"
          :data="templateTableData"
          :fields="json_fields"
          name="模板.xls"
        >
          <el-button icon="el-icon-download" style="float: right;" type="success">下载模板</el-button>
        </download-excel>
        <div style="display: flex; align-items: center; margin-top: 20px">
          <div style="margin-right: 20px">产品信息表</div>
          <el-upload
            class="upload-demo"
            action=""
            :on-change="handleChange"
            :show-file-list="false"
            :auto-upload="false">
            <el-button size="small" type="primary" style="margin-bottom:15px;">上传文件</el-button>
          </el-upload>
        </div>
        <el-table
            :data="massTableData"
            style="width: 100%">
            <el-table-column prop="pid" label="产品代码" ></el-table-column>
            <el-table-column prop="pname" label="产品名称"></el-table-column>
            <el-table-column prop="ptype" label="产品类型"></el-table-column>
            <el-table-column prop="plevel" label="风险等级"></el-table-column>
            <el-table-column prop="pstate" label="产品状态"></el-table-column>
          </el-table>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="handleMassConfirm">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import * as echarts from "echarts";
import axios from '../http/request'
export default {
  name: "Product",
  data() {
    return {
      proMarket: [],
      showNetValueDate: [],
      showGrowthDate: [],
      showNetValueData: [],
      showGrowthData: [],
      fileList: [],
      massTableData: [],
      fileContent: '',
      file: '',
      data: '',
      templateTableData: [
        {
          pid: "12930123",
          pname: "鹏华丰禄债券测试1",
          ptype: "债券",
          plevel: "中低风险",
          pstate: "上市",
        }
      ],
      tableData: [],
      typeOptions: [
        {
          value: '基金',
          label: '基金'
        }, 
        {
          value: '证券',
          label: '证券'
        }, 
        {
          value: '股票',
          label: '股票'
        }
      ],
      levelOptions: [
        {
          value: '高风险',
          label: '高风险'
        }, 
        {
          value: '中高风险',
          label: '中高风险'
        }, 
        {
          value: '中低风险',
          label: '中低风险'
        },
        {
          value: '低风险',
          label: '低风险'
        }
      ],
      stateOptions: [
        {
          value: '上市',
          label: '上市'
        }, 
        {
          value: '未上市',
          label: '未上市'
        }, 
      ],
      json_fields: {
        "产品代码": 'pid',
        "产品名称": 'pname',
        "产品类型": 'ptype',
        "风险等级": 'plevel',
        "产品状态": 'pstate',
      },
      json_fields1: {
        "产品代码": 'pid',
        "产品名称": 'pname',
        "产品类型": 'ptype',
        "风险等级": 'plevel',
        "产品状态": 'pstate',
        "创建/修改日期": 'pstate'
      },
      operateType: 'add',
      dialogVisible: false,
      add_editVisible: false,
      mass_addVisible: false,
      current_pro: {},
      type_filter: [],
      level_filter: [],
      state_filter: [],
      add_editContent: {
        pid: '',
        pname: '',
        ptype: '',
        plevel: '',
        pstate: ''
      },
      searchTypeOptions: [
        {
          label: '产品代码',
          value: '产品代码'
        },
        {
          label: '产品名称',
          value: '产品名称'
        },
        {
          label: '产品类型',
          value: '产品类型'
        },
        {
          label: '产品风险等级',
          value: '产品风险等级'
        },
        {
          label: '产品状态',
          value: '产品状态'
        },
      ],
      search_content: {
        search_type: '',
        search_value: ''
      },
    };
  },
  mounted() {
    this.init_type_fil()
    this.getProInfo()
  },
  methods: {
    handleMassClose() {
      this.mass_addVisible = false
      this.fileContent = ''
      this.massTableData = []
      this.file = ''
      this.data = ''
    },
    handleChange (file, fileList) {
    this.fileContent = file.raw
    const fileName = file.name
    const fileType = fileName.substring(fileName.lastIndexOf('.') + 1)
      if (this.fileContent) {
        if (fileType === 'xlsx' || fileType === 'xls') {
          this.importfile(this.fileContent)
        } else {
          this.$message({
            type: 'warning',
            message: '附件格式错误，请重新上传！'
          })
        }
      } else {
        this.$message({
          type: 'warning',
          message: '请上传附件！'
        })
      }
    },
    importfile (obj) {
      const reader = new FileReader()
      const _this = this
      reader.readAsArrayBuffer(obj)
      reader.onload = function () {
        const buffer = reader.result
        const bytes = new Uint8Array(buffer)
        const length = bytes.byteLength
        let binary = ''
        for (let i = 0; i < length; i++) {
          binary += String.fromCharCode(bytes[i])
        }
          const XLSX = require('xlsx')
          const wb = XLSX.read(binary, {
            type: 'binary'
          })
          const outdata = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]])
          this.data = [...outdata]
          const arr = []
          this.data.map(v => {
            const obj = {}
            obj.pid = v["产品代码"]
            obj.pname = v["产品名称"]
            obj.ptype = v["产品类型"]
            obj.plevel = v["风险等级"]
            obj.pstate = v["产品状态"]
            arr.push(obj)
          })
          _this.massTableData = _this.massTableData.concat(arr)
        }
    },
    // 获取产品列表接口
    getProInfo() {
      axios.get('http://127.0.0.1:8080/production/getProInfo')
        .then(res => {
          this.tableData = [...res.data]
            console.dir(res);
            console.log(res.data);
        })
    },
    // 添加单个产品按钮
    addSingleProduct() {
      this.add_editVisible = true
      this.operateType = 'add'
    },
    // 添加单个产品接口
    addSingleConfirm() {
      const url = this.operateType === 'add' ? 'add' : `edit`
      axios.post(`http://127.0.0.1:8080/production/${url}`, this.add_editContent)
        .then(res => {
          if (res.code === 200) {
            if (this.operateType === 'add') {
              this.$message.success('添加产品成功')
              this.add_editVisible = false
              this.getProInfo()
            } else {
              this.$message.success('修改产品成功')
              this.add_editVisible = false
              this.getProInfo()
            }
          }
        })
      this.add_editVisible = false
      this.getProInfo()
    },
    // 批量添加产品按钮
    massAddProducts() {
      this.mass_addVisible = true;
      this.add_editContent.pid = " "
      this.add_editContent.pname = " "
      this.add_editContent.ptype = " "
      this.add_editContent.plevel = " "
      this.add_editContent.pstate = " "
    },
    // 批量添加产品接口
    handleMassConfirm() {
      for (let i = 0 ; i < this.massTableData.length ; i++) {
        console.log("123132");
        console.dir(this.massTableData[i])
        axios.post('http://127.0.0.1:8080/production/add', this.massTableData[i])
          .then(res => {
            if (res.code === 200) {
              console.log(this.massTableData[i]);
            }
          })
      }
      this.getProInfo()
      this.massTableData = []
      this.mass_addVisible = false
    },
    // 删除产品接口
    handleDelete(index, row) {
      this.$confirm("确认删除产品？")
        .then((_) => {
          console.log(index, row);
          axios.post(`http://127.0.0.1:8080/production/delete/${row.pid}`)
            .then(res => {
              if (res.code === 200) {
                this.$message.success('删除产品成功')
                this.getProInfo()
              }
            })
        })
        .catch((_) => {});
    },
    // 取消新增/修改产品
    cancelAdd_Edit() {
      this.add_editVisible = false;
      this.add_editContent.pid = " "
      this.add_editContent.pname = " "
      this.add_editContent.ptype = " "
      this.add_editContent.plevel = " "
      this.add_editContent.pstate = " "
    },
    // 模糊查询产品接口
    search() {
      console.log(this.search_content);
      let object = {}
      if (this.search_content.search_type === "产品代码") {
        object.pid = this.search_content.search_value
      } else if (this.search_content.search_type === "产品名称") {
        object.pname = this.search_content.search_value
      } else if (this.search_content.search_type === "产品类型") {
        object.ptype = this.search_content.search_value
      } else if (this.search_content.search_type === "产品风险等级") {
        object.plevel = this.search_content.search_value
      } else if (this.search_content.search_type === "产品状态") {
        object.pstate = this.search_content.search_value
      }
      console.dir(object);
      axios.post("http://127.0.0.1:8080/production/search", object)
        .then(res => {
          if (res.code === 200) {
            this.$message.success('查询产品成功')
            this.tableData = res.data
          }
        })

    }, 
    // 重置查询内容
    reset() {
      this.search_content.search_type = " "
      this.search_content.search_value = " "
    },
    // 初始化产品类型筛选
    init_type_fil() {
      this.type_filter = this.tableData.map(item => {
        return {
          text: item.ptype,
          value: item.ptype
        }
      })
      this.type_filter = Array.from(new Set(this.type_filter.map(JSON.stringify)), JSON.parse);
      console.log(this.type_filter);
    },
    // 产品类型筛选
    type_fil(value, row) {
      return row.ptype == value
    },
    // 清除所有图表
    clearEcharts() {
      let myChart = echarts.init(document.getElementById("myChart"));
      myChart.clear()
      let myChart2 = echarts.init(document.getElementById("myChart2"));
      myChart2.clear()
    },
    // 查看产品详情
    async handleShow(index, row) {
      this.dialogVisible = true;
      console.log(row.pname);
      this.current_pro = row;
      await axios.post(`http://127.0.0.1:8080/market/getMarket/${row.pid}`)
        .then(res => {
          if (res.code === 200) {
            this.proMarket = res.data
            console.dir(res.data)
            this.drawLine1()
            this.drawLine2()
          }
        })
    },
    // 修改产品信息
    handleEdit(index, row) {
      this.add_editVisible = true
      this.operateType = 'edit'
      this.add_editContent = {
        pid: row.pid,
        pname: row.pname,
        ptype: row.ptype,
        plevel: row.plevel,
        pstate: row.pstate,
      }
    },
    handleClose(done) {
      this.$confirm("确认关闭？")
        .then((_) => {
          done();
          this.clearEcharts()
        })
        .catch((_) => {});
    },
    drawLine1() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = echarts.init(document.getElementById("myChart"));
      // 绘制图表
      myChart.setOption({
        title: { text: this.current_pro.pname + '单位净值走势', left:'center' },
        tooltip: {
          trigger: 'axis'
        },
        xAxis: {  
          type: 'category',
          // data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
          data: this.proMarket.map(value => {
            return value.mtime
          })
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            // data: [150, 230, 224, 218, 135, 147, 260],
            data: this.proMarket.map(value => {
              return value.netValue
            }),
            type: 'line'
          }
        ]
      });
    },
    drawLine2() {
      let myChart = echarts.init(document.getElementById("myChart2"))
      myChart.setOption({
        title: { text: this.current_pro.pname + '日增长率走势', left:'center' },
        tooltip: {
          trigger: 'axis',
          formatter:function (params) {
            if (params[0].value > 0) 
              return '<div>'+params[0].name + '<br>' + '增长率：<span style="color: #00B83F;">'+params[0].value + '</span>%'+'</div>';
            else 
              return '<div>'+params[0].name + '<br>' + '增长率：<span style="color: red;">'+params[0].value + '</span>%'+'</div>';
          }
        },
        xAxis: {
          type: 'category',
          // data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
          data: this.proMarket.map(value => {
            return value.mtime
          }).slice(0, 10)
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            // data: [20, -10, 12.3, 1.23, -8.2, -0.1, 1],
            data: this.proMarket.map(value => {
              return value.dailyGrowthRate
            }).slice(0, 10),
            type: 'line',
            smooth: true
          }
        ]
      })
    },
    open() {
        this.$nextTick(() => {
        //  执行echarts方法
          this.drawLine1();
          this.drawLine2()
        });
    },
  },
  
};
</script>

<style lang="less" scoped>
.product {
  .search_container {
    display: flex;
    flex-wrap: wrap;
    .search_item {
      width: 26%;
      display: flex;
      align-items: center;
      margin-left: 20px;
      margin-bottom: 10px;
      .name {
        width: 120px;
        vertical-align: middle;
      }
    }
    .search_button {
      margin-left: 20px;
    }
  }
  .add_button {
    margin-top: 20px;
    margin-bottom: 20px;
    .export-excel-wrapper {
      display: inline;
      float: right;
    }
  }
  .add_button {
    text-align: center;
  }
  .el-select {
    width: 100%;
  }
  .content {
    width: 100%;
  }
}
</style>