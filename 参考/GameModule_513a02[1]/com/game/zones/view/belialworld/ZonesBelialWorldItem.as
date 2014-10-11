package com.game.zones.view.belialworld
{
    import com.f1.ui.image.*;
    import com.game.role.util.*;
    import com.game.team.bean.*;
    import com.game.team.view.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.text.*;

    public class ZonesBelialWorldItem extends ListItemBase
    {
        private var _headImg:Image;
        private var _txtName:TextField;
        private var _txtLevel:TextField;
        private var _mcState:MovieClip;
        private var _state:int;
        private var _info:TeamMemberInfo;

        public function ZonesBelialWorldItem()
        {
            super("zone_belial_world_item");
            this.initItem();
            return;
        }// end function

        private function initItem() : void
        {
            this._txtLevel = _content.getChildByName("txt_level") as TextField;
            this._txtName = _content.getChildByName("txt_name") as TextField;
            this._mcState = _content.getChildByName("member_state") as MovieClip;
            this._headImg = new Image();
            this._content.addChild(this._headImg);
            this._headImg.parent.setChildIndex(this._headImg, 2);
            this._headImg.move(-2, 18);
            return;
        }// end function

        override protected function freshItem() : void
        {
            var _loc_1:* = null;
            super.freshItem();
            if (this._info)
            {
                if (RoleLevelUtil.isMasterLevel(this._info.memberlevel))
                {
                    _loc_1 = Params.ROLE_HEAD_PATH + "job" + ((this._info.memberJob - 1) % 3 + 1) + "-4.png";
                }
                else
                {
                    _loc_1 = Params.ROLE_HEAD_PATH + "job" + ((this._info.memberJob - 1) % 3 + 1) + ".png";
                }
                this._headImg.load(_loc_1);
                this._txtName.text = this._info.membername;
                this._txtLevel.text = RoleLevelUtil.getMasterLevel(this._info.memberlevel, "Lv.");
            }
            else
            {
                this._headImg.load("");
                this._txtName.text = "";
                this._txtLevel.text = "";
            }
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        override public function set info(param1) : void
        {
            this._info = param1;
            this.freshItem();
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            this.setState();
            return;
        }// end function

        private function setState() : void
        {
            var _loc_1:* = 0;
            switch(this._state)
            {
                case 0:
                {
                    _loc_1 = 3;
                    break;
                }
                case 1:
                {
                    _loc_1 = 1;
                    break;
                }
                case 2:
                {
                    _loc_1 = 2;
                    break;
                }
                default:
                {
                    _loc_1 = 1;
                    break;
                    break;
                }
            }
            this._mcState.gotoAndStop(_loc_1);
            return;
        }// end function

    }
}
