
Kindrdfood = Kindrdfood || {};


Kindrdfood.families = Kindrdfood.families || {};

Kindrdfood.families.editFamilyMember = {

	init: function(){

		Kindrdfood.formValidations.familyMembers.validateFamilyMemberForm("family-member-form");

		Kindrdfood.ajaxSpecific.ajaxUpdateUrl.init();
	}
}