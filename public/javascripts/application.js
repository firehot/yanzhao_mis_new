// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.noConflict();
jQuery(function($) {
	$("#org_info_tree").jOrgChart({
		chartElement: '#org_info_tree_wrapper'
	});
	$("#position_info_tree").jOrgChart({
		chartElement: '#position_info_tree_wrapper'
	});
	/*menu_bar的点击事件*/
	$('#menu_bar .group_name').click(function() {
		var cur_el = $(this).next('.navigation:first')[0];
		$('#menu_bar .navigation').each(function(index, el) {
			if (el == cur_el) $(el).toggle();
			else $(el).hide();
		});
	});
    //职位信息权限设置中,处理选择事件
    $('.position_info_select').click(function(){
        if($(this).attr('checked')){
            $(this).next('.destroy_flag').val('0');
        }
        else
            $(this).next('.destroy_flag').val('1');
    });

    //手工票领用及审核,起止票号不可为空
    var check_hand_invoice_form = function(e){
        var from_no = $('.from_no').val();
        var to_no = $('.to_no').val();
        if(from_no == '' || to_no == '')
        {
            $('.bill_no_error').show();
            e.preventDefault();
        }
        else
        {
            $('.bill_no_error').hide();
        }
    };
    $('#hand_invoice_form').on('submit',check_hand_invoice_form);
});

//yanzhao-bill begin
//单据选择器对象，主要用于选择单据，并将选择的单据传给服务器
var SelectHelper = {};

SelectHelper.Selector = Class.create();
SelectHelper.Selector.prototype = {

	cached: new Hash(),
	//缓存的全部单据id
	cached_sumInfo: {},
	//缓存合计信息
	selected_sumInfo: {
		sum_goods_num: 0,
		sum_fee: 0,
		sum_goods_fee: 0,
		sum_k_hand_fee: 0,
		sum_k_carrying_fee: 0,
		sum_act_pay_fee: 0,
		sum_storage_fee: 0,
		sum_clear_fee: 0
	},
	//构造函数
	//bill_ids 缓存的票据数组
	//cached_sumInfo 缓存的合计信息
	//sum_info_span 选择信息显示的容器
	//bill_type carrying_bill inout_bill
	initialize: function(bill_ids, cached_sumInfo, sum_info_span, bill_type) {
		this.cached_sumInfo = cached_sumInfo;
		this.sum_info_span = sum_info_span;
		this.bill_type = bill_type;
		bill_ids.each(function(bill) {
			//初始情况下所有单据都未被选中
			//判断json对象的属性名称,在提款票据中为carrying_bill
			//在提货票据中是inout_bill
			/*
                     if(typeof(bill.carrying_bill) != 'undefined')
                     this.cached.set(bill.carrying_bill.id,false);
                     else
                     this.cached.set(bill.inout_bill.id,false);
                     */

			this.cached.set(bill.id, false);
		},
		this);
	},
	//选择单张单据
	//select_object 自服务器传输的json对象[bill,is_select]
	//see CarryingBillController.select
	select_bill: function(select_object) {

		var bill;
		/*
                  if(typeof(select_object[0].carrying_bill) != 'undefined')
                  bill= select_object[0].carrying_bill;
                  else
                  bill= select_object[0].inout_bill;
                  */
		bill = select_object[0];
		var is_select = select_object[1] == "true" ? true: false;

		this.cached.set(bill.id, is_select);
		this.re_sum(bill, is_select)
		this.update_sumInfo();

	},

	select_all: function(is_select) {
		this.cached.each(function(pair) {
			this.cached.set(pair.key, is_select);
		},
		this);
		//如果全选,则设置已选定的合计信息为缓存合计信息
		if (is_select) this.selected_sumInfo = Object.clone(this.cached_sumInfo);
		else this.selected_sumInfo = {
			sum_goods_num: 0,
			sum_fee: 0,
			sum_goods_fee: 0,
			sum_k_hand_fee: 0,
			sum_k_carrying_fee: 0,
			sum_act_pay_fee: 0,
			sum_storage_fee: 0,
			sum_clear_fee: 0
		};
		this.update_sumInfo();
		this.update_page_selected();
	},
	//选择单据后重新计算合计
	re_sum: function(bill, is_select) {
		if (is_select) {

			this.selected_sumInfo.sum_goods_num += bill.goods_num;
			this.selected_sumInfo.sum_fee += bill.fee;
			this.selected_sumInfo.sum_goods_fee += bill.goods_fee;
			this.selected_sumInfo.sum_k_hand_fee += bill.k_hand_fee;
			this.selected_sumInfo.sum_k_carrying_fee += bill.k_carrying_fee;
			this.selected_sumInfo.sum_act_pay_fee += bill.act_pay_fee;
			this.selected_sumInfo.sum_clear_fee += bill.clear_fee;
			this.selected_sumInfo.sum_storage_fee += bill.storage_fee;

		}
		else {

			this.selected_sumInfo.sum_goods_num -= bill.goods_num;
			this.selected_sumInfo.sum_fee -= bill.fee;
			this.selected_sumInfo.sum_goods_fee -= bill.goods_fee;
			this.selected_sumInfo.sum_k_hand_fee -= bill.k_hand_fee;
			this.selected_sumInfo.sum_k_carrying_fee -= bill.k_carrying_fee;
			this.selected_sumInfo.sum_act_pay_fee -= bill.act_pay_fee;
			this.selected_sumInfo.sum_clear_fee -= bill.clear_fee;
			this.selected_sumInfo.sum_storage_fee -= bill.storage_fee;
		}
	},
	//得到当前选择的单据数
	selected_count: function() {
		var selected_count = 0;

		this.cached.each(function(pair) {
			if (pair.value) selected_count++;
		},
		this);
		return selected_count;
	},
	//更新选择信息
	update_sumInfo: function() {
		if (this.selected_count() == 0) {
			$(this.sum_info_span).update("当前未选中任何票据");
			return;

		}
		var sum_des;
		if (this.bill_type == "carrying_bill") sum_des = new Template("共选中票据" + this.selected_count() + "张 " + "合计: 货物件数#{sum_goods_num} 运费#{sum_fee} 货款#{sum_goods_fee} 扣手续费#{sum_k_hand_fee}" + " 扣运费#{sum_k_carrying_fee} 实付货款 #{sum_act_pay_fee}");
		else sum_des = new Template("共选中票据" + this.selected_count() + "张 " + "合计: 货物件数#{sum_goods_num} 运费#{sum_fee} 货款#{sum_goods_fee} 仓储费#{sum_storage_fee}" + " 清仓费#{sum_clear_fee}");

		$(this.sum_info_span).update(sum_des.evaluate(this.selected_sumInfo));

	},
	//更新页面上被选中的数据
	//页面上的checkbox 命名规则为cbx_单据id
	update_page_selected: function() {
		this.cached.each(function(pair) {
			try {
				$("cbx_" + pair.key).checked = pair.value;
			}
			catch(ex) {}
		},
		this);
	},
	//将选中单据转化为url参数,便于提交到服务器进行操作
	//param_name 要转化的参数名称
	toQueryStr: function() {
		var selected_array = new Array();
		this.cached.each(function(pair) {
			if (pair.value) selected_array.push(pair.key);
		},
		this);
		var ret = new Hash({
			"bills[]": selected_array
		});
		return ret.toQueryString();

	}
};
//票据操作工具类,提供添加票据,计算票据合计等功能
var billOperateUtil = {};
//根据从服务器返回的json对象添加单张票据
//callback_json [ bill_json 自服务器端返回的票据对象,bill_operate 票据操作类型]
//页面上的table id = 'list_table'
billOperateUtil.addBill = function(callback_json) {
	var the_bill;
	//操作类型
	var operate_type = callback_json[1];
	the_bill = callback_json[0];
	//判断单据是否已在提款列表
	if ($('added_bill_' + the_bill.id)) {
		$('error_span').update('票据' + the_bill.bill_no + '已在选择列表中');
		return false;
	}
	var tr_template = new Template("<tr class='added_bill' id='added_bill_#{id}'>" + "<input type='hidden' name='bills[]' value='#{id}'/>" + "<input class='goods_fee' type='hidden' value='#{goods_fee}' id='goods_fee_#{id}' />" + "<input class='fee' type='hidden' value='#{fee}' id='fee_#{id}' />" + "<input class='k_hand_fee' type='hidden' value='#{k_hand_fee}' id='k_hand_fee_#{id}' />" + "<input class='k_carrying_fee' type='hidden' value='#{k_carrying_fee}' id='k_carrying_fee_#{id}' />" + "<input class='k_insured_fee' type='hidden' value='#{k_insured_fee}' id='k_insured_fee_#{id}' />" + "<input class='act_pay_fee' type='hidden' value='#{act_pay_fee}' id='act_pay_fee_#{id}' />" + "<input class='storage_fee' type='hidden' value='#{storage_fee}' id='storage_fee_#{id}' />" + "<td>#{index}</td>" + "<td>#{bill_no}</td>" + "<td>#{goods_no}</td>" + "<td>#{sender_name}</td>" + "<td>#{goods_fee}</td>" + "<td>#{fee}</td>" + (operate_type == 'tk_info' ? "<td>#{k_hand_fee}</td><td>#{k_carrying_fee}</td><td>#{k_insured_fee}</td><td>#{act_pay_fee}</td>": "") + (operate_type == 'deliver' ? "<td>#{storage_fee}</td>": "") + (operate_type == 'clear_info' ? "<td><input type='text' id='clear_fee_#{id}' class='clear_fee' name='clear_fee[]' value='#{clear_fee}' style='width : 50px;font-size : 1.2em;height : 25px;border : 2px solid blue;'/></td>": "") + "<td><a class='red_text' style='cursor:pointer;' onclick=$('added_bill_#{id}').remove();billOperateUtil.cal_sum();>删除</a></td></tr>");
	//计算原有单据,便于计算序号
	var index = $$('#list_table tr.added_bill').size() + 1;
	the_bill.index = index;
	var tr = tr_template.evaluate(the_bill);
	$('list_table').insert(tr);

	var clear_field_id = 'clear_fee_' + the_bill.id;
	//添加验证,清仓费用应为数字
	if ($(clear_field_id)) {
		var clear_field = new LiveValidation(clear_field_id, {
			validMessage: ''
		});
		clear_field.add(Validate.Numericality, {
			notANumberMessage: 'X'
		});
		//注册清仓费用变化时重新合计
		$(clear_field_id).observe('change', billOperateUtil.cal_sum.bindAsEventListener(this));
	}
	billOperateUtil.cal_sum();
};
//添加票据后计算合计
billOperateUtil.cal_sum = function() {
	var cal_single_sum = function(fee_type) {
		var sum_fee = 0;
		var rs = $$('#list_table input.' + fee_type);
		rs.each(function(el) {
			sum_fee += parseFloat(el.value);
		});
		//更新合计单元格
		//加上try,防止出现异常
		try {
			$('sum_' + fee_type).update(sum_fee);
		}
		catch(ex) {;
		}
	};
	cal_single_sum('fee');
	cal_single_sum('goods_fee');
	cal_single_sum('k_hand_fee');
	cal_single_sum('k_carrying_fee');
	cal_single_sum('k_insured_fee');
	cal_single_sum('act_pay_fee');
	cal_single_sum('storage_fee');
	cal_single_sum('clear_fee');
};
var util = {};
util.getOs = function() {
	if (navigator.userAgent.indexOf("MSIE") > 0) return 1;
	if (navigator.userAgent.indexOf("Firefox") > 0) return 2;
	return 0;
};

util.bookmarkit = function(url) {
	switch (util.getOs()) {
	case 1:
		window.external.addFavorite(url, '票据管理系统');
		break;
	case 2:
		window.sidebar.addPanel('票据管理系统', url, "");
		break;
	case 0:
		alert("加入收藏失败，您使用的浏览器不支持这个功能");
		break;
	}
};
//设为首页
util.setHome = function(obj, url) {
	obj.style.behavior = 'url(#default#homepage)';
	obj.setHomePage(url);
	return false;
};
util.translat_calendar = function() {
	//  日历控件的汉化
	_translations = {
		"OK": "确定",
		"Now": "现在",
		"Today": "当天",
		"Clear": "取消"
	};
	Date.weekdays = $w("1 2 3 4 5 6 7");
	Date.months = $w("一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一 十二");
};

//yanzhao-bill end
var com = {};
com.yanzhao = {};
//选择用户
com.yanzhao.UserSelector = Class.create();
com.yanzhao.UserSelector.prototype = {
	initialize: function() {},
	//传入orgs数组和容器元素
	//orgs 机构数组
	//el_wrapper 用户列表容器
	//el_select_display 已选择用户显示容器
	set_param: function(orgs, el_wrapper, el_select_disp) {
		this.orgs = orgs;
		this.el_wrapper = el_wrapper;
		this.el_select_disp = el_select_disp;
	},
	//选择/不选择某个org的全部人员
	select_all: function(org, select) {
		var css_selector = '#' + org + ' input[type=checkbox]';
		var users = $$(css_selector);
		users.each(function(user_el) {
			user_el.checked = select;
		},
		this);
	},
	//选择给定的机构
	select_org: function(org_id) {
		this.orgs.each(function(the_org) {
			$(the_org).hide();
		});
		$(org_id).show();
	},
	//显示第一个机构的人员信息
	show_first_org: function() {
		if (this.orgs.size() > 0) $(this.orgs.first()).show();
	},
	//得到已选择的用户数组,返回{user_id,username}类型的数组
	selected_users: function() {
		var css_selector = '#' + this.el_wrapper + ' input[type=checkbox]';
		var users = $$(css_selector);
		var ret = $A();
		users.each(function(el_user) {
			if (el_user.checked) {
				var the_user = {
					id: el_user.id,
					username: el_user.value
				};
				ret.push(the_user);
			}
		},
		this);
		return ret;
	},
	//更新选择显示
	update_select_display: function(users) {
		users.each(function(the_user) {
			//    disp +="<div class='radius-box float-left user_wrap'>"+the_user.user_name + "</div>";
			var user_div = this.create_user_display(the_user);
			//判断用户是否已存在
			if ($('selected_' + the_user.id)) return;
			$(this.el_select_disp).insert(user_div);
		},
		this);
	},
	//创建界面上显示的用户信息
	create_user_display: function(user_obj) {
		var user_div = new Element('div');
		user_div.addClassName('radius-box float-left user_wrap');
		user_div.id = 'selected_' + user_obj.id;
		user_div.update(user_obj.username);
		var hidden_user = new Element('input', {
			type: 'hidden',
			name: "select_user[]",
			value: user_obj.id
		});
		user_div.insert(hidden_user);

		var btn_delete = new Element('span');
		btn_delete.addClassName('delete');
		btn_delete.update('删');
		btn_delete.observe('click', function() {
			user_div.remove();
		});
		user_div.insert(btn_delete);
		return user_div;

	}

};

/*nested form helper*/
com.yanzhao.nestedFormHelper = {};
/*删除方法*/
com.yanzhao.nestedFormHelper.remove_fields = function(link) {
	$(link).previous("input[type=hidden]").value = "1";
	$(link).up().up(".fields").hide();

	//重新计算合计
	if (typeof(material_selector) != 'undefined' && material_selector) material_selector.cal_sum();
}
/* 添加方法*/
com.yanzhao.nestedFormHelper.add_fields = function(link, association, content, content_wrap) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g");
	if (content_wrap.blank()) $(link).up().insert({
		bottom: content.replace(regexp, new_id)
	});
	else $(content_wrap).insert({
		bottom: content.replace(regexp, new_id)
	});
};
/*结算表的Form监听器,用于自动计算*/
com.yanzhao.settlement_form_observer = function() {
	var form = $('setttlement_form');
	//得到相关的费用
	var start_fee = parseFloat($F('settlement_start_fee'));
	var start_carrying_fee = parseFloat($F('settlement_start_carrying_fee'));
	var start_net_income = start_fee - start_carrying_fee;
	$('settlement_start_net_income').value = start_net_income;
	var start_radio = parseFloat($F('settlement_start_radio'));
	var start_push_money = Math.round(start_net_income * start_radio / 100);
	$('settlement_start_push_money').value = start_push_money;
	//计算返程费用
	var back_fee = parseFloat($F('settlement_back_fee'));
	var back_carrying_fee = parseFloat($F('settlement_back_carrying_fee'));
	var back_net_income = back_fee - back_carrying_fee;
	$('settlement_back_net_income').value = back_net_income;
	var back_radio = parseFloat($F('settlement_back_radio'));
	var back_push_money = Math.round(back_net_income * back_radio / 100);
	$('settlement_back_push_money').value = back_push_money;
	$('settlement_total_push_money').value = start_push_money + back_push_money;
	//计算应补合计
	var subsidies = $$("input[name*='subsidies']");
	var sum_subsidy = 0.0;
	subsidies.each(function(el) {
		if (el.id.include('value')) sum_subsidy += parseFloat(el.value);
	});

	$('settlement_total_subsidy').value = sum_subsidy;
	//计算其他应扣合计
	var sum_other_deduction = 0;
	var other_deductions = $$("input[name*='other_settlement_line_deductions']");
	other_deductions.each(function(el) {
		if (el.id.include('value')) sum_other_deduction += parseFloat(el.value);
	});

	$('settlement_total_other_deduction').value = sum_other_deduction;

	//计算应扣合计
	var deductions = $$("input[name*='deductions']");
	var sum_deduction = 0;
	deductions.each(function(el) {
		if (el.id.include('value')) sum_deduction += parseFloat(el.value);
	});

	$('settlement_total_deduction').value = sum_deduction;
	var act_push_money = start_push_money + back_push_money + sum_subsidy - sum_deduction;
	$('settlement_act_push_money').value = act_push_money;
};

/*选择物品的处理*/
com.yanzhao.MaterialSelector = Class.create();
com.yanzhao.MaterialSelector.prototype = {
	initialize: function() {},
	//target_el 选择物品后用于更新物品信息的容器
	//结构如下: <tr><td><input class='material_name' /></td></tr>
	set_target_el: function(target_el) {
		this.target_el = target_el;
	},
	//设置当前可选择的物品数组
	set_material_array: function(materials) {
		this.storage_materials = materials;
	},
	//在界面中选择物品
	select_material: function(material_id) {
		this.storage_materials.each(function(s_m) {
			if (s_m.material.id == material_id) this.selected_material = s_m;
		},
		this);
		return this.selected_material;
	},
	//确认选择,在物品选择窗口上按确定按钮
	//error_span 未选择任何商品时显示错误信息
	perform_select: function(err_span) {
		if (typeof(this.selected_material) == 'undefined' || ! this.selected_material) $(err_span).update('当前未选择任何物品.');
		else {
			this.update_target_el();
			this.storage_materials = null;
			this.selected_material = null;
			return true;
		}
		return false;
	},
	//根据选择物品更新出入库单据上的明细列表
	update_target_el: function() {
		el_id = this.target_el.select('.material_id').first();
		el_name = this.target_el.select('.material_name').first();
		el_unit = this.target_el.select('.material_unit').first();
		el_price = this.target_el.select('.material_price').first();
		//普通票据，价格自票据设置信息中取
		el_common_invoice_price = this.target_el.select('.common_invoice_price').first();
		el_qty = this.target_el.select('.material_qty').first();
		el_total = this.target_el.select('.material_total').first();
		el_id.value = this.selected_material.material.id;
		el_name.value = this.selected_material.material.name;
		el_unit.value = this.selected_material.material.unit;
		if (typeof(el_price) != 'undefined') {
			el_price.value = this.selected_material.avg_price;
			//以下注册监听事件
			el_price.observe('change', this.cal_line_amt.bindAsEventListener(this, el_price, el_qty, el_total));
			el_qty.observe('change', this.cal_line_amt.bindAsEventListener(this, el_price, el_qty, el_total));
			//先计算
			this.cal_line_amt(null, el_price, el_qty, el_total);

		}
		if (typeof(el_common_invoice_price) != 'undefined') {
			el_common_invoice_price.value = this.selected_material.material.unit_price;
			el_common_invoice_price.observe('change', this.cal_line_amt.bindAsEventListener(this, el_common_invoice_price, el_qty, el_total));
			el_qty.observe('change', this.cal_line_amt.bindAsEventListener(this, el_common_invoice_price, el_qty, el_total));
			//先计算
			this.cal_line_amt(null, el_common_invoice_price, el_qty, el_total);

		}

	},
	//计算每行合计
	cal_line_amt: function(evt, el_price, el_qty, el_total) {
		var line_amt = parseFloat(el_price.value) * parseFloat(el_qty.value);
		el_total.value = line_amt;
		this.cal_sum();

	},
	//计算合计
	cal_sum: function() {

		var sum = 0;
		var line_totals = $('line_fields_wrap').select('.material_total');
		line_totals.each(function(line_amt) {
			//判断是否是被删除的数据
			if (line_amt.up().up().style['display'] != 'none') sum += parseFloat(line_amt.value);
		});
		$('sum_field').value = sum;
	}

};
//导出到word
var export_word = function(el_id) {
	try {
		var el = document.getElementById(el_id);
		var sel = document.body.createTextRange();
		sel.moveToElementText(el);
		sel.select();
		sel.execCommand("Copy");

		var word = new ActiveXObject("Word.Application");
		var doc = word.Documents.Add("", 0, 1);
		word.Application.Visible = false;
		var range = doc.Range(0, 1);
		range.Paste();

		word.Application.Visible = true;
	}
	catch(e) {
		window.alert(e.message);
		window.alert("导出失败,请确认您已安装word软件,并调整了IE的安全设置.");
	}
};
//导出数据到excel, ie only
var set_style = function(ws) {
	ws.Columns.ColumnWidth = 30;
	ws.Columns('A:A').ColumnWidth = 20;
};
var export_excel = function(table_content) {
	try {
		window.clipboardData.setData("Text", table_content);
		ExApp = new ActiveXObject("Excel.Application");
		var ExWBk = ExApp.Workbooks.add();
		var ExWSh = ExWBk.ActiveSheet;
		ExApp.DisplayAlerts = false;
		set_style(ExWSh);
		ExApp.visible = true;
		ExWSh.Paste();
	}
	catch(e) {
		window.alert(e.message);
		window.alert("导出失败,请确认您已安装excel软件,并调整了了IE的安全设置.");
		return false;
	}
};
//将calendar_select翻译为汉语
document.observe("dom:loaded", util.translat_calendar);
//工资表自动计算功能
document.observe("dom:loaded", function() {
	var enter2tab = function(evt) {
		if (evt.keyCode == Event.KEY_RETURN) {

			var inputs = $$('#salary_table_form input[type=text]:not([readonly])');
			var idx = inputs.indexOf(this);
			if (idx == inputs.length - 1) {
				inputs[0].focus();
				inputs[0].select();

			}
			else {
				inputs[idx + 1].focus();
				inputs[idx + 1].select();

			}
			return false;

		}

	};
	//一次绑定多个element事件
	$$('#salary_table_form input[type=text]:not([readonly])').invoke('observe', 'keypress', enter2tab);
	//自动计算工资
	var cal_salary = function() {
		var parent_tr = $(this).up('tr');
		var work_days = parseFloat(parent_tr.down('input.work_days').value);
		var other_added = parseFloat(parent_tr.down('input.other_added').value);
		var deducted_fee = parseFloat(parent_tr.down('input.deducted_fee').value);
		var salary_base = parseFloat(parent_tr.down('input.salary_base').value);
		var work_year_base = parseFloat(parent_tr.down('input.work_year_base').value);
		var position_base = parseFloat(parent_tr.down('input.position_base').value);
		var position_base_2 = parseFloat(parent_tr.down('input.position_base_2').value);
		var food_base = parseFloat(parent_tr.down('input.food_base').value);
		var house_base = parseFloat(parent_tr.down('input.house_base').value);
		var base_salary = Math.round(salary_base / 26 * work_days);
		var work_year_salary = Math.round(work_year_base / 26 * work_days);
		var position_salary = Math.round(position_base / 26 * work_days);
		var position_2_salary = Math.round(position_base_2 / 26 * work_days);
		var food_salary = Math.round(food_base / 26 * work_days);
		var house_salary = Math.round(house_base / 26 * work_days);
		var work_days_added = 0;
		//月出勤满23天补助100
		if (work_days >= 23) {
			work_days_added += 100;
			//每多1天补助20
			work_days_added += (work_days - 23) * 20;
		}
		var act_salary = base_salary + work_year_salary + position_salary + position_2_salary + food_salary + house_salary + work_days_added + other_added - deducted_fee;
		//更新界面字段
		parent_tr.down('input.base_salary').value = base_salary.toFixed(2);
		parent_tr.down('input.work_year_salary').value = work_year_salary.toFixed(2);
		parent_tr.down('input.position_salary').value = position_salary.toFixed(2);
		parent_tr.down('input.position_2_salary').value = position_2_salary.toFixed(2);
		parent_tr.down('input.food_salary').value = food_salary.toFixed(2);
		parent_tr.down('input.house_salary').value = house_salary.toFixed(2);
		parent_tr.down('input.work_days_added').value = work_days_added.toFixed(2);
		parent_tr.down('input.act_salary').value = act_salary.toFixed(2);
		cal_sum();

	};
	//计算合计
	var cal_sum = function() { ['work_days', 'base_salary', 'work_year_salary', 'other_added', 'deducted_fee', 'position_salary', 'position_2_salary', 'food_salary', 'house_salary', 'work_days_added', 'act_salary'].each(function(s) {
			var tmp = 0;
			$$('.' + s).each(function(el) {
				tmp += parseFloat($(el).value)

			});
			if ($('sum_' + s)) $('sum_' + s).update(tmp.toFixed(2));

		});

	};
	//一次绑定多个element事件
	$$('input.work_days,input.other_added,input.deducted_fee').invoke('observe', 'change', cal_salary);
	cal_sum();

});
document.observe("dom:loaded", function() {
    //工资表打印功能
	//打印入账联
	var print_1 = function(evt, print_signature) {
		var s_table = $('salary_table_show').cloneNode(true);
		s_table.setStyle({
			width: '280mm',
			borderCollapse: 'collapse'
		});
		s_table.select('.salary_table_title').invoke('setStyle', {
			fontSize: '20px',
			textAlign: 'center'
		});
		s_table.select('th,td').invoke('setStyle', {
			height: '18px',
			textAlign: 'center',
			border: 'thin solid #000'
		});
		s_table.select('.salary_table_title td,.salary_table_title th').invoke('setStyle', {
			border: 'none'
		});
		s_table.select('.salary_table_foot td,.salary_table_foot th').invoke('setStyle', {
			border: 'none'
		});
		//如果是打印发放联
		if (print_signature) s_table.select('.signature').invoke('show');
		var printer = new com.yanzhao.web_print();
		var print_config = {
			orient: 2,
			top: 0,
			left: 0,
			width: '170mm',
			height: '270mm',
			content: s_table.outerHTML
		};
		printer.print_table(print_config);
	};
	if ($('btn_print_salary_table_1')) $('btn_print_salary_table_1').observe('click', print_1.bindAsEventListener(print_1, false));
	//打印发放联
	if ($('btn_print_salary_table_2')) $('btn_print_salary_table_2').observe('click', print_1.bindAsEventListener(print_1, true));

	//手工运单和机打运单合计自动计算功能
	var cal_line_amt = function(evt) {
		var tr = evt.element().up('tr.material_inout_line');
		var el_price = parseFloat(tr.down('input.material_price').getValue());
		var el_qty = parseFloat(tr.down('input.material_qty').getValue());
		var el_package_volume = parseFloat(tr.down('.package_volume').getValue());
		var material_total = (el_price * el_qty).ceil();
		var package_qty = (el_qty * el_package_volume).ceil();
		tr.down('input.material_total').setValue(material_total);
		tr.down('.package_qty').update(package_qty);

	};
	$$('tr.material_inout_line .material_price,tr.material_inout_line .material_qty').invoke('observe', 'change', cal_line_amt);

	//运单盘查信息表自动计算
	var cal_invoice_check = function(evt) {
		var computer_balance_count = parseFloat($('invoice_check_computer_balance_count').getValue());
		var computer_receive_count = parseFloat($('invoice_check_computer_receive_count').getValue());
		var computer_used_count = parseFloat($('invoice_check_computer_used_count').getValue());
		var computer_invalid_count = parseFloat($('invoice_check_computer_invalid_count').getValue());
		var computer_rest_count = computer_balance_count + computer_receive_count - computer_used_count - computer_invalid_count;
		var hand_balance_count = parseFloat($('invoice_check_hand_balance_count').getValue());
		var hand_receive_count = parseFloat($('invoice_check_hand_receive_count').getValue());
		var hand_used_count = parseFloat($('invoice_check_hand_used_count').getValue());
		var hand_invalid_count = parseFloat($('invoice_check_hand_invalid_count').getValue());
		var hand_rest_count = hand_balance_count + hand_receive_count - hand_used_count - hand_invalid_count;
		var hand_invoice_package_volume = parseFloat($('hand_invoice_package_volume').getValue());
		$('computer_rest_count').update(computer_rest_count);
		var hand_rest_display = Math.floor(hand_rest_count / hand_invoice_package_volume) + '本' + (hand_rest_count % hand_invoice_package_volume) + '份'
		$('hand_rest_count').update(hand_rest_display);
	};
	$$('#invoice_check_computer_used_count,#invoice_check_computer_invalid_count,#invoice_check_hand_used_count,#invoice_check_hand_invalid_count').invoke('observe', 'change', cal_invoice_check);
	//手工票领取表单,单价不可修改,运单编号在领取时不填写
	$$('#new_hand_invoice_shippment .material_price').invoke('writeAttribute', 'readonly', true);
	$$('#new_computer_invoice_shippment .material_price').invoke('writeAttribute', 'readonly', true);
	//$$('#new_hand_invoice_shippment .invoice_bill_no').invoke('hide');
	$$('#new_computer_invoice_shippment .invoice_bill_no,#edit_computer_invoice_shippment .invoice_bill_no,#edit_computer_invoice_shippment .invoice_package_qty').invoke('hide');
	//显示手工票审核界面时,自动计算合计金额
	//员工资料-岗位列表变化,修改响应的工资项目金额
	$$('#employee_position_id').invoke('observe', 'change', function() {
		var positions_object = $('positions_object').getValue().evalJSON();
		var cur_position_id = $('employee_position_id').getValue();
		var p_obj = positions_object.detect(function(o) {
			return o["id"] == cur_position_id;
		});
		//设置工资基数项目
		if ( !! p_obj) {
			$('employee_salary_base').setValue(p_obj["salary_base"]);
			$('employee_position_base').setValue(p_obj["position_base"]);
			$('employee_house_base').setValue(p_obj["house_base"]);
			$('employee_food_base').setValue(p_obj["food_base"]);
		}

	});
	//默认不显示查询区间设置界面
	$$('#hand_fee_list_toggle').invoke('observe', 'click', function() {
		$$(".hand_fee_list_content").invoke("toggle");
	});

});

