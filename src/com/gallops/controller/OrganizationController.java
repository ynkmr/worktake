package com.gallops.controller;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gallops.model.Organization;
import com.gallops.service.OrganizationService;
import com.gallops.util.StringConvert;

@Controller
public class OrganizationController {

	@Autowired
	OrganizationService organizationService;

	@RequestMapping("/organization/all.do")
	@ResponseBody
	public List<Map<String, String>> list() {
		List<Map<String, String>> list = organizationService.selectView();
		return list;
	}

	@RequestMapping("/organization/allOthers.do")
	@ResponseBody
	public List<Organization> listOthers(@RequestParam("id") String id) {
		List<Organization> lst = organizationService.findAllOthers(id);
		return lst;
	}

	@RequestMapping("/organization/view.do")
	public String index() {
		return "organizations";
	}

	@RequestMapping(value = "/organization/save.do", method = RequestMethod.POST)
	@ResponseBody
	public int save(@RequestBody Map<String, String> obj) {
		int rtn = -1;
		if (obj.containsKey("id") && (obj.get("id").length() > 0)) {
			if (obj.containsKey("parent_id")
					&& StringUtils.isNotEmpty(obj.get("parent_id"))) {
				Organization parent = organizationService.findById(obj
						.get("parent_id"));
				obj.put("all_ids", parent.getAll_ids() + ";" + obj.get("id"));
			} else {
				obj.put("all_ids", obj.get("id"));
			}
			rtn = organizationService.updateByMap(obj);
		} else {
			String id = StringConvert.getUUIDString();
			obj.put("id", id);
			if (obj.containsKey("parent_id")
					&& StringUtils.isNotEmpty(obj.get("parent_id"))) {
				Organization parent = organizationService.findById(obj
						.get("parent_id"));
				obj.put("all_ids", parent.getAll_ids() + ";" + obj.get("id"));
			} else {
				obj.put("all_ids", obj.get("id"));
			}
			rtn = organizationService.insertByMap(obj);
		}
		return rtn;
	}

	@RequestMapping("/organization/remove.do")
	@ResponseBody
	public int delete(@RequestParam("id") String id) {
		int rtn = organizationService.delete(id);
		return rtn;
	}

}
