package com.game.fight.view
{
    import com.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.fight.control.*;
    import com.game.player.view.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class PKTips extends BaseBox
    {
        private var _placeHold:MovieClip;
        private var bg:MovieClip;
        private var _levelTxt:TextField;
        private var _nameTxt:TextField;
        private var close_btn:BaseButton;
        private var _image:PlayerImage;
        private var laskAttacked:int;
        private var _lastinfo:RoleInfo;
        private var _info:RoleInfo;
        private var _role:IRole;

        public function PKTips()
        {
            loadDisplay("res/pkbox.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("pkbox");
            this.initUI();
            Global.popManager.addedPKTips(this);
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._placeHold = getDisplayChildByName("mc_placeHold");
            this.bg = getDisplayChildByName("bg");
            this._image = new PlayerImage();
            this._image.setScale(0.9, 0.9);
            this._placeHold.addChild(this._image);
            this._image.addEventListener(MouseEvent.ROLL_OVER, this.__roleOver);
            this._image.addEventListener(MouseEvent.CLICK, this.__imageClick);
            this._image.addEventListener(MouseEvent.ROLL_OUT, this.__roleOut);
            this._levelTxt = getDisplayChildByName("txt_level");
            this._nameTxt = getDisplayChildByName("txt_name");
            this.close_btn = new BaseButton(getDisplayChildByName("close_btn"));
            this.close_btn.addEvtListener(MouseEvent.CLICK, this.__close);
            this.updateView();
            return;
        }// end function

        public function setInfo(param1:IRole) : void
        {
            if (param1.info)
            {
                this._info = param1.info;
                this._lastinfo = this._info;
                this._role = param1;
                this.updateView();
                this.laskAttacked = getTimer();
                this.addEventLister();
            }
            return;
        }// end function

        private function updateView() : void
        {
            if (UILoaded && this._info)
            {
                this.setName(this._info.name);
                this.setHeadPic();
                this.setLevel(this._info.level);
            }
            return;
        }// end function

        private function addEventLister() : void
        {
            return;
        }// end function

        private function enterFrame(event:Event = null) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this.laskAttacked > 15000)
            {
                this._lastinfo = null;
                if (hasEventListener(Event.ENTER_FRAME))
                {
                    removeEventListener(Event.ENTER_FRAME, this.enterFrame);
                }
            }
            return;
        }// end function

        public function setName(param1:String) : void
        {
            if (!param1)
            {
                param1 = this._info.name;
            }
            this._nameTxt.htmlText = param1;
            this.bg.width = this._nameTxt.textWidth + 40;
            this.bg.x = this._nameTxt.x + this._nameTxt.width / 2 - this.bg.width / 2;
            return;
        }// end function

        public function setHeadPic() : void
        {
            var _loc_1:* = null;
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                _loc_1 = Params.ROLE_HEAD_PATH + "job" + ((this._info.job - 1) % 3 + 1) + "-4.png";
            }
            else
            {
                _loc_1 = Params.ROLE_HEAD_PATH + "job" + ((this._info.job - 1) % 3 + 1) + ".png";
            }
            if (this._image)
            {
                this._image.setUrl(_loc_1);
            }
            return;
        }// end function

        public function setLevel(param1:uint) : void
        {
            return;
        }// end function

        private function __roleOver(event:MouseEvent) : void
        {
            var _loc_2:* = new GlowFilter(16773120, 0.8, 5, 5, 5);
            this._image.filters = [_loc_2];
            return;
        }// end function

        private function __roleOut(event:MouseEvent) : void
        {
            this._image.filters = [];
            return;
        }// end function

        private function __imageClick(event:MouseEvent) : void
        {
            UserObj.getInstance().selectRole = this._role;
            this.visible = false;
            if (RoleList.getInstance().player.info.currentSkill)
            {
                RoleList.getInstance().player.info.currentSkill.targetRole = this._role;
                FightControl.getInstance().checkAndAttack(RoleList.getInstance().player);
            }
            else
            {
                FightControl.getInstance().useSkill(UserObj.getInstance().playerInfo.defaultSkillId, this._role);
            }
            return;
        }// end function

        private function okFun() : void
        {
            FightControl.getInstance().reqChangePKStateMessage(2);
            UserObj.getInstance().selectRole = this._role;
            this.visible = false;
            if (RoleList.getInstance().player.info.currentSkill)
            {
                RoleList.getInstance().player.info.currentSkill.targetRole = this._role;
                FightControl.getInstance().checkAndAttack(RoleList.getInstance().player);
            }
            else
            {
                FightControl.getInstance().useSkill(UserObj.getInstance().playerInfo.defaultSkillId, this._role);
            }
            return;
        }// end function

        private function cancelFun() : void
        {
            this.visible = false;
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.visible = false;
            return;
        }// end function

        public function get lastinfo() : RoleInfo
        {
            return this._lastinfo;
        }// end function

        public function set lastinfo(param1:RoleInfo) : void
        {
            this._lastinfo = param1;
            return;
        }// end function

    }
}
