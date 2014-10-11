package com.game.skill.view
{
    import com.f1.utils.*;
    import com.game.operationpanel.view.*;
    import com.model.vo.*;
    import flash.text.*;

    public class SkillIntroduceItem extends SkillItemBase
    {
        private var _txtSkillName:TextField;
        private var _txtCreatWay:TextField;
        private var _txtDescribe:TextField;
        private var _icon:SkillBox;
        private var _info:SkillInfo;
        private var _isStudy:Boolean;

        public function SkillIntroduceItem()
        {
            super("skil_introduce_item");
            return;
        }// end function

        override protected function getComp() : void
        {
            this._txtSkillName = TextField(this._content.getChildByName("txt_skill_name"));
            this._txtDescribe = TextField(this._content.getChildByName("txt_describe"));
            this._txtDescribe.mouseWheelEnabled = false;
            this._txtCreatWay = TextField(this._content.getChildByName("txt_creat_way"));
            this._txtCreatWay.wordWrap = true;
            this._txtCreatWay.multiline = true;
            return;
        }// end function

        override public function set info(param1) : void
        {
            this._info = param1;
            this.freshItem();
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        override protected function freshItem() : void
        {
            this._txtDescribe.htmlText = this._info.q_desc;
            this._txtSkillName.text = this._info.q_skillName;
            this._txtCreatWay.htmlText = this._info.q_skill_origin ? (this._info.q_skill_origin) : ("");
            if (!this._icon)
            {
                this._icon = new SkillBox("skillBoxBg");
                this._icon.setImageSize(54, 54);
                this._icon.info = this._info;
                this.addChild(this._icon);
                this._icon.move(14, 25);
            }
            return;
        }// end function

        public function get isStudy() : Boolean
        {
            return this._isStudy;
        }// end function

        public function set isStudy(param1:Boolean) : void
        {
            this._isStudy = param1;
            if (this._isStudy)
            {
                this.filters = [];
            }
            else
            {
                this.filters = [ColorFilter.getGrayFilter()];
            }
            return;
        }// end function

    }
}
