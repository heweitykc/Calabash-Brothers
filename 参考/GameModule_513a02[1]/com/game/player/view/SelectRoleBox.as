package com.game.player.view
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.game.buff.view.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class SelectRoleBox extends Component
    {
        private var _placeHold:MovieClip;
        private var _levelTxt:TextField;
        private var _nameTxt:TextField;
        private var btn_operation:BaseButton;
        private var close_btn:BaseButton;
        private var mc_hp:MovieClip;
        private var stripWidth:Number;
        private var _image:PlayerImage;
        private var _buffContainer:HBox;
        private var buffIcons:Dictionary;
        private var _info:RoleInfo;
        private var _lastInfo:RoleInfo;

        public function SelectRoleBox()
        {
            loadDisplay("res/selectplayerbox.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("selectplayerbox");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._placeHold = getDisplayChildByName("mc_placeHold");
            this._image = new PlayerImage();
            this._image.x = this._placeHold.x;
            this._image.y = this._placeHold.y;
            addChild(this._image);
            this._levelTxt = getDisplayChildByName("txt_level");
            this._nameTxt = getDisplayChildByName("txt_name");
            this.btn_operation = new BaseButton(getDisplayChildByName("btn_operation"));
            this.btn_operation.setText(LanguageCfgObj.getInstance().getByIndex("11026"));
            this.btn_operation.addEvtListener(MouseEvent.CLICK, this.showMenu);
            this.close_btn = new BaseButton(getDisplayChildByName("close_btn"));
            this.close_btn.addEvtListener(MouseEvent.CLICK, this.__close);
            this.mc_hp = getDisplayChildByName("mc_hp");
            this.stripWidth = this.mc_hp.width;
            this._buffContainer = new HBox();
            this._buffContainer.horizontal = true;
            this._buffContainer.intervalX = 1.5;
            this._buffContainer.intervalY = 3;
            this._buffContainer.oneRow = 5;
            this._buffContainer.move(90, 95);
            addChild(this._buffContainer);
            return;
        }// end function

        private function getBuffInfo(param1:uint) : BuffInfo
        {
            var _loc_3:* = null;
            var _loc_2:* = this._info.buffs;
            var _loc_4:* = _loc_2.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                if ((_loc_2[_loc_5] as BuffInfo).q_buff_id == param1)
                {
                    return _loc_2[_loc_5];
                }
                _loc_5++;
            }
            return null;
        }// end function

        private function __updateBuff(event:RoleEvent) : void
        {
            if (this.buffIcons == null)
            {
                this.buffIcons = new Dictionary();
            }
            var _loc_2:* = event.obj.t;
            var _loc_3:* = this.buffIcons[_loc_2];
            var _loc_4:* = (event.target as RoleInfo).getBuffByModelId(_loc_2);
            if (event.obj.op && event.obj.op == "AU")
            {
                if (_loc_4 && (!_loc_4.q_ico || _loc_4.q_ico == ""))
                {
                    return;
                }
                if (_loc_3)
                {
                    _loc_3.setInfo(_loc_4, true, false);
                }
                else
                {
                    _loc_3 = new BuffIcon();
                    _loc_3.setInfo(_loc_4, true, false);
                    this.buffIcons[_loc_2] = _loc_3;
                    this._buffContainer.add(_loc_3);
                }
            }
            else if (event.obj.op && event.obj.op == "D")
            {
                if (_loc_4)
                {
                    _loc_3.setInfo(_loc_4, true, false);
                }
                else
                {
                    this._buffContainer.remove(_loc_3);
                    this.buffIcons[_loc_2] = null;
                    delete this.buffIcons[_loc_2];
                }
            }
            return;
        }// end function

        private function addListener() : void
        {
            if (this._lastInfo)
            {
                this._lastInfo.removeEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
                this._lastInfo.removeEvtListener(RoleEvent.UPDATE_HP, this.__updateHp);
                this._lastInfo.removeEvtListener(RoleEvent.UPDATE_BUFF, this.__updateBuff);
                this._lastInfo.removeEvtListener(RoleEvent.UPDATE_HEAD_PIC, this.__updateHeadPic);
            }
            if (this._info != null)
            {
                this._info.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
                this._info.addEvtListener(RoleEvent.UPDATE_HP, this.__updateHp);
                this._info.addEvtListener(RoleEvent.UPDATE_BUFF, this.__updateBuff);
                this._info.addEvtListener(RoleEvent.UPDATE_HEAD_PIC, this.__updateHeadPic);
            }
            return;
        }// end function

        private function removeListener() : void
        {
            if (this._lastInfo)
            {
                this._lastInfo.removeEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
                this._lastInfo.removeEvtListener(RoleEvent.UPDATE_HP, this.__updateHp);
                this._lastInfo.removeEvtListener(RoleEvent.UPDATE_BUFF, this.__updateBuff);
                this._lastInfo.removeEvtListener(RoleEvent.UPDATE_HEAD_PIC, this.__updateHeadPic);
            }
            return;
        }// end function

        private function showMenu(event:MouseEvent) : void
        {
            if (this._info)
            {
                PlayerOptPopMenu.getInstance().show(this._info, this, 2);
            }
            return;
        }// end function

        private function __updateLevel(event:RoleEvent) : void
        {
            var _loc_2:* = event.currentTarget as RoleInfo;
            this.setLevel(_loc_2.level);
            this.addRoleTip();
            return;
        }// end function

        private function __updateHp(event:RoleEvent) : void
        {
            var _loc_2:* = event.currentTarget as RoleInfo;
            this.setBlood(_loc_2);
            return;
        }// end function

        private function addRoleTip() : void
        {
            return;
        }// end function

        private function __updateHeadPic(event:RoleEvent) : void
        {
            this.setHeadPic();
            return;
        }// end function

        public function setInfo(param1:RoleInfo) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1)
            {
                this._info = param1;
                this.updateBtn();
                this.updateView();
                this.addListener();
                for each (_loc_2 in this._info.buffs)
                {
                    
                    _loc_3 = new RoleEvent(RoleEvent.UPDATE_BUFF);
                    _loc_3.obj = {op:"AU", t:_loc_2.q_buff_id};
                    this._info.dispatchEvent(_loc_3);
                }
                this._lastInfo = this._info;
            }
            else
            {
                this.removeListener();
            }
            return;
        }// end function

        private function updateBtn() : void
        {
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (this._info.roleType != RoleType.ROLE_TYPE_PLAYER || _loc_1.zones_type == ZoneType.ZONES_RED_FORTRESS)
            {
                this.btn_operation.visible = false;
            }
            else
            {
                this.btn_operation.visible = true;
            }
            return;
        }// end function

        private function updateView() : void
        {
            this.setName(this._info.name);
            this.setHeadPic();
            this.setLevel(this._info.level);
            this.setBlood(this._info);
            this.buffIcons = null;
            this._buffContainer.reset();
            return;
        }// end function

        public function setName(param1:String) : void
        {
            if (!param1)
            {
                param1 = this._info.name;
            }
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.zones_type == ZoneType.ZONES_RED_FORTRESS)
            {
                this._nameTxt.htmlText = "?????";
            }
            else
            {
                this._nameTxt.htmlText = param1;
            }
            return;
        }// end function

        public function setHeadPic() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this._info.job;
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                _loc_2 = Params.ROLE_HEAD_PATH + "job" + ((_loc_1 - 1) % 3 + 1) + "-4.png";
            }
            else
            {
                _loc_2 = Params.ROLE_HEAD_PATH + "job" + ((_loc_1 - 1) % 3 + 1) + ".png";
            }
            if (this._image)
            {
                this._image.setUrl(_loc_2);
            }
            return;
        }// end function

        public function setLevel(param1:uint) : void
        {
            param1 = RoleLevelUtil.isMasterLevel(param1) == true ? (param1 - Params.ROLE_MAX_LEVEL) : (param1);
            this._levelTxt.htmlText = param1.toString();
            return;
        }// end function

        public function setBlood(param1:RoleInfo) : void
        {
            this.mc_hp.mc_mask.width = this.stripWidth * param1.HP / param1.HPMax;
            this.mc_hp.txt.text = param1.HP + "/" + param1.HPMax;
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.visible = false;
            UserObj.getInstance().selectRole = null;
            MapControl.getInstance().currentGameScene.showSelectRole(null);
            return;
        }// end function

    }
}
