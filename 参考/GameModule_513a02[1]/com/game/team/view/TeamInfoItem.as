package com.game.team.view
{
    import com.f1.interfaces.ui.list.*;
    import com.game.role.view.*;
    import com.game.team.bean.*;
    import flash.display.*;
    import flash.text.*;

    public class TeamInfoItem extends ListItemBase implements IItem
    {
        private var txtName:TextField;
        private var txtMemberCount:TextField;
        private var txtCaptainLev:TextField;
        private var txtMaxLevel:TextField;
        private var txtAverageLev:TextField;
        private var txtCaptainLevIcon:RoleLevelIcon;
        private var txtMaxLevelIcon:RoleLevelIcon;
        private var txtAverageIcon:RoleLevelIcon;
        private var _info:MapTeamInfo;

        public function TeamInfoItem()
        {
            super("teamInfoCue");
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        override public function set info(param1) : void
        {
            this._info = param1;
            if (param1)
            {
                this.freshItem();
            }
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txtAverageLev = _content.getChildByName("txtAverageLev") as TextField;
            this.txtCaptainLev = _content.getChildByName("txtCaptainLev") as TextField;
            this.txtMaxLevel = _content.getChildByName("txtMaxLevel") as TextField;
            this.txtMemberCount = _content.getChildByName("txtMemberCount") as TextField;
            this.txtName = _content.getChildByName("txtName") as TextField;
            mcBack = _content.getChildByName("back") as MovieClip;
            this.txtCaptainLevIcon = new RoleLevelIcon();
            this.txtCaptainLevIcon.x = this.txtCaptainLev.x;
            this.txtCaptainLevIcon.y = this.txtCaptainLev.y;
            _content.addChild(this.txtCaptainLevIcon);
            this.txtAverageIcon = new RoleLevelIcon();
            this.txtAverageIcon.x = this.txtAverageLev.x;
            this.txtAverageIcon.y = this.txtAverageLev.y;
            _content.addChild(this.txtAverageIcon);
            this.txtMaxLevelIcon = new RoleLevelIcon();
            this.txtMaxLevelIcon.x = this.txtMaxLevel.x;
            this.txtMaxLevelIcon.y = this.txtMaxLevel.y;
            _content.addChild(this.txtMaxLevelIcon);
            this.mouseChildren = false;
            return;
        }// end function

        override protected function freshItem() : void
        {
            this.txtMemberCount.text = this.info.teamnum.toString();
            this.txtName.text = this.info.captainname.toString();
            this.txtAverageLev.text = "";
            this.txtCaptainLev.text = "";
            this.txtMaxLevel.text = "";
            this.txtAverageIcon.level = this.info.averagelv;
            this.txtCaptainLevIcon.level = this.info.captainlv;
            this.txtMaxLevelIcon.level = this.info.highestlv;
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            this.txtAverageLev.textColor = param1;
            this.txtCaptainLev.textColor = param1;
            this.txtMaxLevel.textColor = param1;
            this.txtMemberCount.textColor = param1;
            this.txtName.textColor = param1;
            this.txtAverageIcon.textColor = param1;
            this.txtCaptainLevIcon.textColor = param1;
            this.txtMaxLevelIcon.textColor = param1;
            return;
        }// end function

        public function get key()
        {
            return;
        }// end function

        public function get obj()
        {
            return;
        }// end function

        public function set obj(param1) : void
        {
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
