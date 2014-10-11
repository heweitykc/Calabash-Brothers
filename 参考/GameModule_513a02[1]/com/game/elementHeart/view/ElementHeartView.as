package com.game.elementHeart.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.elementHeart.control.*;
    import com.game.elementHeart.event.*;
    import com.game.elementHeart.model.*;
    import com.game.role.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class ElementHeartView extends Component
    {
        private const LANG:String = "lang_elementHeart";
        private var _playerview:RoleView;
        private var _elementValueTxt:TextField;
        private var _oneKeySwallowBtn:BaseButton;
        private var _lockBtn:BaseButton;
        private var _cangBtn:BaseButton;
        private var _elementBoxes:HBox;
        private var _locking:Boolean = false;
        private var _boxOnPlayer:Array;
        private const BOX_LEN:int = 7;
        private var _configLimit:Array;
        private const BACKPACK_NUM:int = 21;
        private var openNumOnPlayer:int = 0;
        private var _btnHelp:BaseButton;
        private var _valueBg:DisplayObject;
        private const lOCATE:Array;
        private var _data:ElementHeartData;

        public function ElementHeartView()
        {
            this._boxOnPlayer = new Array();
            this.lOCATE = [{x:58, y:246}, {x:38, y:166}, {x:72, y:88}, {x:160, y:52}, {x:255, y:92}, {x:289, y:170}, {x:269, y:245}];
            loadDisplay("res/elementHeart.swf");
            this._data = ElementHeartData.getInstance();
            if (!this._configLimit)
            {
                this._configLimit = GlobalCfgObj.getInstance().getElementLimit();
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("elementHeart_main");
            super.displayReady();
            this.initUI();
            this.addEvent();
            this.onAddedToStage();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._elementValueTxt = getDisplayChildByName("elementHeart");
            this._oneKeySwallowBtn = new BaseButton(getDisplayChildByName("oneKeySwallowBtn"));
            this._oneKeySwallowBtn.setText(LanguageCfgObj.getInstance().getByIndex("eh1003", this.LANG));
            StringTip.create(this._oneKeySwallowBtn, LanguageCfgObj.getInstance().getByIndex("eh1029", this.LANG));
            this._lockBtn = new BaseButton(getDisplayChildByName("lockBtn"));
            this._lockBtn.setText(LanguageCfgObj.getInstance().getByIndex("eh1005", this.LANG));
            StringTip.create(this._lockBtn, LanguageCfgObj.getInstance().getByIndex("eh1030", this.LANG));
            this._cangBtn = new BaseButton(getDisplayChildByName("cangBtn"));
            StringTip.create(this._cangBtn, LanguageCfgObj.getInstance().getByIndex("eh1031", this.LANG));
            this._cangBtn.setText(LanguageCfgObj.getInstance().getByIndex("eh1006", this.LANG));
            this._btnHelp = new BaseButton(getDisplayChildByName("btnHelp"));
            StringTip.create(this._btnHelp, GlobalCfgObj.getInstance().getElementHelpTips());
            this._valueBg = getDisplayChildByName("tipicon");
            this._elementBoxes = new HBox();
            this._elementBoxes.horizontal = true;
            this._elementBoxes.intervalX = 1;
            this._elementBoxes.intervalY = 3;
            this._elementBoxes.oneRow = 7;
            var _loc_3:* = 0;
            while (_loc_3 < this.BOX_LEN)
            {
                
                _loc_1 = new ElementIconItem("elementHeart_playerIcon");
                this._boxOnPlayer.push(_loc_1);
                _loc_2 = this.lOCATE[_loc_3];
                _loc_1.type = ElementLocateType.ONPLAYER;
                _loc_1.index = _loc_3;
                _loc_1.move(_loc_2.x, _loc_2.y);
                addChild(_loc_1);
                _loc_3++;
            }
            var _loc_4:* = 0;
            while (_loc_4 < this.BACKPACK_NUM)
            {
                
                _loc_1 = new ElementIconItem("elementHeart_backpackIcon");
                _loc_1.type = ElementLocateType.BACKPANCK;
                _loc_1.index = _loc_4;
                this._elementBoxes.add(_loc_1);
                _loc_4++;
            }
            this._elementBoxes.move(19, 344);
            addChild(this._elementBoxes);
            return;
        }// end function

        private function test() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < 4)
            {
                
                _loc_1 = this._elementBoxes.getContent(_loc_2);
                _loc_1.setInfo(PropUtil.createElementHeartById(131010));
                _loc_2++;
            }
            return;
        }// end function

        private function addEvent() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClick);
            this.addEvtListener(MouseEvent.RIGHT_CLICK, this.mouseClick);
            this.addEvtListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            this.addEvtListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function addOrRemoveRole(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1)
            {
                if (this._playerview)
                {
                    this.addOrRemoveRole(false);
                }
                _loc_2 = UserObj.getInstance().playerInfo;
                _loc_3 = new PlayerInfo();
                _loc_3.armor = _loc_2.armor;
                _loc_3.wingInfo = _loc_2.wingInfo;
                _loc_3.weapon = _loc_2.weapon;
                _loc_3.weapon_other = _loc_2.weapon_other;
                _loc_3.showID = _loc_2.showID;
                this._playerview = new RoleView();
                this._playerview.mouseEnabled = false;
                this._playerview.info = _loc_3;
                this._playerview.auto = true;
                this._playerview.direct = 180;
                this._playerview.setAct(Params.ACTION_STAND_ID, true);
                this._playerview.move(199, 281);
                addChild(this._playerview);
            }
            else
            {
                if (this._playerview.parent)
                {
                    this._playerview.parent.removeChild(this._playerview);
                }
                this._playerview.finalize();
                this._playerview = null;
            }
            return;
        }// end function

        protected function onAddedToStage(event:Event = null) : void
        {
            this.addOrRemoveRole(true);
            this._data.addEvtListeners([EHeartEvent.ADD_BACKPACK, EHeartEvent.ADD_PLAYER, EHeartEvent.DELETE_BACKPACK, EHeartEvent.DELETE_PLAYER, EHeartEvent.FRESH_BACKPACK, EHeartEvent.FRESH_PlAYER, EHeartEvent.CHANGE_VALUE, EHeartEvent.DRAG_FALSE], this.updatePanel);
            ElementHeartControl.getInstance().reqContainer(ElementLocateType.BACKPANCK);
            this.updateLock();
            this._elementValueTxt.text = this._data.value.toString();
            return;
        }// end function

        private function updateLock() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo.level;
            if (this._configLimit.length != this.BOX_LEN)
            {
                Log.log("配置格子不匹配");
                return;
            }
            this.openNumOnPlayer = 0;
            var _loc_4:* = 0;
            while (_loc_4 < this.BOX_LEN)
            {
                
                _loc_2 = this._boxOnPlayer[_loc_4] as ElementIconItem;
                _loc_3 = this._configLimit[_loc_4];
                if (_loc_1 >= _loc_3)
                {
                    _loc_2.setOpen(true);
                    var _loc_6:* = this;
                    var _loc_7:* = this.openNumOnPlayer + 1;
                    _loc_6.openNumOnPlayer = _loc_7;
                    if (!_loc_2.info)
                    {
                        StringTip.dispose(_loc_2);
                    }
                }
                else
                {
                    _loc_2.setOpen(false);
                    _loc_5 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("eh1007", this.LANG), [RoleLevelUtil.getMasterLv(_loc_3)]);
                    StringTip.create(_loc_2, _loc_5);
                }
                _loc_4++;
            }
            return;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this.addOrRemoveRole(false);
            this.locking = false;
            this._data.removeEvtListeners([EHeartEvent.ADD_BACKPACK, EHeartEvent.ADD_PLAYER, EHeartEvent.DELETE_BACKPACK, EHeartEvent.DELETE_PLAYER, EHeartEvent.FRESH_BACKPACK, EHeartEvent.FRESH_PlAYER, EHeartEvent.CHANGE_VALUE], this.updatePanel);
            return;
        }// end function

        private function removeEvtListeners(param1:Array, param2:Function) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in param1)
            {
                
                removeEvtListener(_loc_3, param2);
            }
            return;
        }// end function

        private function updatePanel(event:EHeartEvent) : void
        {
            var item:ElementHeartInfo;
            var itemIcon:ElementIconItem;
            var o:*;
            var info:ElementHeartInfo;
            var tips:String;
            var rect:Rectangle;
            var i:int;
            var obj:ElementHeartInfo;
            var j:int;
            var obj1:ElementHeartInfo;
            var e:* = event;
            switch(e.type)
            {
                case EHeartEvent.CHANGE_VALUE:
                {
                    this._elementValueTxt.text = this._data.value.toString();
                    this.updateTips();
                    break;
                }
                case EHeartEvent.ADD_BACKPACK:
                {
                    item = e.obj;
                    itemIcon = this._elementBoxes.getContent(item.index);
                    if (itemIcon)
                    {
                        itemIcon.setInfo(item);
                    }
                    break;
                }
                case EHeartEvent.ADD_PLAYER:
                {
                    this.updateTips();
                    item = e.obj;
                    if (item.index < this._boxOnPlayer.length)
                    {
                        itemIcon = this._boxOnPlayer[item.index];
                        itemIcon.setInfo(item);
                    }
                    break;
                }
                case EHeartEvent.DELETE_BACKPACK:
                {
                    item = e.obj;
                    itemIcon = this._elementBoxes.getContent(item.index);
                    if (itemIcon)
                    {
                        itemIcon.setInfo(null);
                    }
                    break;
                }
                case EHeartEvent.DELETE_PLAYER:
                {
                    this.updateTips();
                    item = e.obj;
                    if (item.index < this._boxOnPlayer.length)
                    {
                        itemIcon = this._boxOnPlayer[item.index];
                        itemIcon.setInfo(null);
                    }
                    break;
                }
                case EHeartEvent.FRESH_BACKPACK:
                {
                    i;
                    while (i < this.BACKPACK_NUM)
                    {
                        
                        itemIcon = this._elementBoxes.getContent(i);
                        itemIcon.setInfo(null);
                        i = (i + 1);
                    }
                    var _loc_3:* = 0;
                    var _loc_4:* = e.obj;
                    while (_loc_4 in _loc_3)
                    {
                        
                        obj = _loc_4[_loc_3];
                        itemIcon = this._elementBoxes.getContent(obj.index);
                        if (itemIcon)
                        {
                            itemIcon.setInfo(obj);
                        }
                    }
                    break;
                }
                case EHeartEvent.FRESH_PlAYER:
                {
                    this.updateTips();
                    j;
                    while (j < this.openNumOnPlayer)
                    {
                        
                        itemIcon = this._boxOnPlayer[j];
                        itemIcon.setInfo(null);
                        j = (j + 1);
                    }
                    var _loc_3:* = 0;
                    var _loc_4:* = e.obj;
                    while (_loc_4 in _loc_3)
                    {
                        
                        obj1 = _loc_4[_loc_3];
                        itemIcon = this._boxOnPlayer[obj1.index];
                        if (itemIcon)
                        {
                            itemIcon.setInfo(obj1);
                        }
                    }
                    break;
                }
                case EHeartEvent.DRAG_FALSE:
                {
                    o = e.obj;
                    info = o.value.info;
                    tips = "<font color=\'#" + info.color + "\'>[" + info.q_name + "]</font>";
                    tips = LanguageCfgObj.getInstance().getByIndex("eh1024", this.LANG) + tips;
                    rect = this.getBounds(FrameworkGlobal.stage);
                    if (!rect.contains(o.p.x, o.p.y))
                    {
                        Global.popManager.cue(tips, null, null, function () : void
            {
                ElementHeartControl.getInstance().reqRemveEheart(o.value.type, info.index);
                return;
            }// end function
            );
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function updateTips() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = "";
            _loc_1 = _loc_1 + (LanguageCfgObj.getInstance().getByIndex("eh1008", this.LANG) + " " + this._data.value);
            for each (_loc_3 in this._data.onPlayerInfo)
            {
                
                _loc_1 = _loc_1 + ("<br/><font color = \'#" + PropUtil.getElementColor(_loc_3.q_quality).toString(16) + "\'>" + _loc_3.q_name + "</font> " + LanguageCfgObj.getInstance().getByIndex("eh1009", this.LANG) + _loc_3.q_level + " " + _loc_3.getAttrTips());
            }
            StringTip.create(this._elementValueTxt, _loc_1);
            StringTip.create(this._valueBg, _loc_1);
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.type == MouseEvent.RIGHT_CLICK)
            {
                this.locking = false;
                return;
            }
            if (event.target is ElementIconItem)
            {
                if (this._locking)
                {
                    _loc_2 = event.target as ElementIconItem;
                    if (!_loc_2.info)
                    {
                        return;
                    }
                    ElementHeartControl.getInstance().reqLock(_loc_2.type, _loc_2.info.index);
                }
                return;
            }
            else
            {
                if (this._lockBtn == event.target)
                {
                    this.locking = !this._locking;
                    return;
                }
                if (this._locking)
                {
                    this.locking = false;
                }
            }
            switch(event.target)
            {
                case this._cangBtn:
                {
                    ElementHeartControl.getInstance().openOrCloseElementHousePanel();
                    break;
                }
                case this._oneKeySwallowBtn:
                {
                    ElementHeartControl.getInstance().reqAutoSwallow(ElementLocateType.BACKPANCK);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function set locking(param1:Boolean) : void
        {
            this._locking = param1;
            if (param1)
            {
                Global.primaryCursorManager.showLock();
            }
            else
            {
                Global.primaryCursorManager.hide();
            }
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
