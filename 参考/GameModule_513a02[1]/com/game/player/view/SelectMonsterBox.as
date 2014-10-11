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
    import com.game.role.model.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class SelectMonsterBox extends Component
    {
        private var _levelTxt:TextField;
        private var _nameTxt:TextField;
        private var close_btn:BaseButton;
        private var mc_hp:MovieClip;
        private var mc_hp_back:MovieClip;
        private var stripWidth:Number;
        private var whiteMask:BaseSprite;
        private var _buffContainer:HBox;
        private var buffIcons:Dictionary;
        private var _info:RoleInfo;
        private var canSlipe:Boolean = true;

        public function SelectMonsterBox()
        {
            loadDisplay("res/selectmonsterbox.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("selectmonsterbox");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._levelTxt = getDisplayChildByName("txt_level");
            this._nameTxt = getDisplayChildByName("txt_name");
            this.close_btn = new BaseButton(getDisplayChildByName("close_btn"));
            this.close_btn.addEvtListener(MouseEvent.CLICK, this.__close);
            this.mc_hp = getDisplayChildByName("mc_hp");
            this.mc_hp_back = getDisplayChildByName("mc_hp_back");
            this.stripWidth = this.mc_hp.width;
            this._nameTxt.selectable = false;
            this._levelTxt.selectable = false;
            this._buffContainer = new HBox();
            this._buffContainer.horizontal = true;
            this._buffContainer.intervalX = 1.5;
            this._buffContainer.intervalY = 3;
            this._buffContainer.oneRow = 5;
            this._buffContainer.move(90, 95);
            addChild(this._buffContainer);
            return;
        }// end function

        private function __updateBuff(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.buffIcons == null)
            {
                this.buffIcons = new Dictionary();
            }
            _loc_2 = event.obj.t;
            _loc_4 = (event.target as RoleInfo).getBuffByModelId(_loc_2);
            _loc_3 = this.buffIcons[_loc_2];
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
                }
            }
            return;
        }// end function

        private function addListener() : void
        {
            if (this._info != null)
            {
                this._info.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
                this._info.addEvtListener(RoleEvent.UPDATE_BUFF, this.__updateBuff);
                this._info.addEvtListener(RoleEvent.UPDATE_HP, this.__updateHp);
            }
            return;
        }// end function

        private function removeListener() : void
        {
            if (this._info)
            {
                this._info.removeEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
                this._info.removeEvtListener(RoleEvent.UPDATE_BUFF, this.__updateBuff);
                this._info.removeEvtListener(RoleEvent.UPDATE_HP, this.__updateHp);
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

        public function setInfo(param1:RoleInfo) : void
        {
            if (UILoaded)
            {
                if (!param1 || param1 && param1.monster_type == MonsterType.MONSTER_NORMAL)
                {
                    this.removeListener();
                    visible = false;
                    this._info = null;
                    return;
                }
                if (this._info && param1 == this._info)
                {
                    this.updateView();
                    visible = true;
                }
                else if (param1 != null)
                {
                    this.mc_hp_back.mc_mask.width = this.stripWidth * param1.HP / param1.HPMax;
                    this.removeListener();
                    this._info = param1;
                    this.addListener();
                    this.updateView();
                    visible = true;
                }
            }
            return;
        }// end function

        private function updateView() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this.setName(this._info.name);
            this.setLevel(this._info.level);
            this.setBlood(this._info);
            this.buffIcons = null;
            this._buffContainer.reset();
            for each (_loc_1 in this._info.buffs)
            {
                
                _loc_2 = new RoleEvent(RoleEvent.UPDATE_BUFF);
                _loc_2.obj = {op:"AU", t:_loc_1.q_buff_id};
                this._info.dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function setName(param1:String) : void
        {
            if (!param1)
            {
                param1 = this._info.name;
            }
            return;
        }// end function

        public function setLevel(param1:uint) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (_loc_2.zones_type == ZoneType.ZONES_RED_FORTRESS)
            {
                this._levelTxt.htmlText = "lv.??? ?????";
            }
            else
            {
                _loc_3 = this._info.name.split(LanguageCfgObj.getInstance().getByIndex("11025"));
                this._levelTxt.htmlText = "lv." + this._info.level + " " + _loc_3.pop();
            }
            return;
        }// end function

        public function setBlood(param1:RoleInfo) : void
        {
            this.mc_hp.mc_mask.width = this.stripWidth * param1.HP / param1.HPMax;
            this.mc_hp.txt.text = param1.HP + "/" + param1.HPMax;
            if (this._info == param1)
            {
                TweenLite.to(this.mc_hp_back.mc_mask, 0.3, {width:this.mc_hp.mc_mask.width});
            }
            else
            {
                TweenLite.killTweensOf(this.mc_hp_back.mc_mask);
                this.mc_hp_back.mc_mask.width = this.mc_hp.mc_mask.width;
            }
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
