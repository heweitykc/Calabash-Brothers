package com.game.elementHeart.view
{
    import com.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.f1.ui.tips.*;
    import com.game.elementHeart.control.*;
    import com.game.elementHeart.event.*;
    import com.game.elementHeart.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;

    public class ElementHousePanel extends BaseBox
    {
        private const SWF:String = "res/elementHouse.swf";
        private var _closeBtn:BaseButton;
        private var _listBox:HBox;
        private var _allPackBtn:BaseButton;
        private var _packOutBtn:BaseButton;
        private var _oneKeySwallon:BaseButton;
        private var _scrollpanel:ScrollPanel;
        private var _bagSp:Sprite;
        private var _bagContainer:HBox;
        private var _pick:Boolean = false;
        private var LANG:String = "lang_elementHeart";
        private var _data:ElementHeartData;

        public function ElementHousePanel()
        {
            this._data = ElementHeartData.getInstance();
            loadDisplay(this.SWF);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("elementHouse_main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._bagContainer = new HBox();
            this._bagContainer.intervalX = 2;
            this._bagContainer.intervalY = 3;
            this._bagContainer.oneRow = 7;
            this._bagContainer.y = 4;
            this._bagSp = new Sprite();
            this._bagSp.addChild(this._bagContainer);
            this._closeBtn = new BaseButton(getDisplayChildByName("closeBtn"));
            this._allPackBtn = new BaseButton(getDisplayChildByName("allPackBtn"));
            this._packOutBtn = new BaseButton(getDisplayChildByName("packOutBtn"));
            StringTip.create(this._packOutBtn, LanguageCfgObj.getInstance().getByIndex("eh1032", this.LANG));
            StringTip.create(this._allPackBtn, LanguageCfgObj.getInstance().getByIndex("eh1033", this.LANG));
            this._oneKeySwallon = new BaseButton(getDisplayChildByName("oneKeySwallon"));
            StringTip.create(this._oneKeySwallon, LanguageCfgObj.getInstance().getByIndex("eh1034", this.LANG));
            this._packOutBtn.setText(LanguageCfgObj.getInstance().getByIndex("eh1002", this.LANG));
            this._allPackBtn.setText(LanguageCfgObj.getInstance().getByIndex("eh1004", this.LANG));
            this._oneKeySwallon.setText(LanguageCfgObj.getInstance().getByIndex("eh1003", this.LANG));
            this._scrollpanel = new ScrollPanel(343, 427);
            this._scrollpanel.content = this._bagSp;
            this._scrollpanel.move(18, 64);
            addChild(this._scrollpanel);
            var _loc_1:* = 0;
            while (_loc_1 < this.maxGrid())
            {
                
                _loc_2 = new ElementHeartBackIcon("backpackbox_bg");
                this._bagContainer.add(_loc_2, false, 0, 0);
                (this._bagContainer.getContent(_loc_1) as ElementIconItem).setInfo(null);
                _loc_1++;
            }
            this._scrollpanel.updateThumb();
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.remvoeFromStage);
            this._bagContainer.addEventListener("rightClick", this.__pack);
            FrameworkGlobal.addMsgListen(WndCloseEvt.CLOSE, this.__wndClose);
            return;
        }// end function

        private function __wndClose(param1:WndCloseEvt) : void
        {
            switch(param1.wnd)
            {
                case "com.game.primaryrole.view::PrimaryRoleMainPanel":
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __pack(event:MouseEvent = null) : void
        {
            var _loc_2:* = null;
            if (event.target is ElementIconItem)
            {
                _loc_2 = event.target as ElementIconItem;
                if (_loc_2.info)
                {
                    ElementHeartControl.getInstance().reqGainOne(_loc_2.info.index);
                }
            }
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            if (event.target is ElementIconItem)
            {
                if (this._pick)
                {
                    this.__pack(event);
                }
                return;
            }
            else
            {
                if (event.target == this._packOutBtn)
                {
                    this.pick = !this._pick;
                    return;
                }
                if (this._pick)
                {
                    this.pick = false;
                    return;
                }
            }
            switch(event.target)
            {
                case this._closeBtn:
                {
                    this.close();
                    break;
                }
                case this._allPackBtn:
                {
                    ElementHeartControl.getInstance().reqGainAll();
                    break;
                }
                case this._packOutBtn:
                {
                    this.pick = !this._pick;
                    break;
                }
                case this._oneKeySwallon:
                {
                    ElementHeartControl.getInstance().reqAutoSwallow(ElementLocateType.HOUSE);
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function set pick(param1:Boolean) : void
        {
            this._pick = param1;
            if (param1)
            {
                Global.primaryCursorManager.showGetIcon();
            }
            else
            {
                Global.primaryCursorManager.hide();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            this._data.addEvtListeners([EHeartEvent.ADD_HOUSE, EHeartEvent.DELETE_HOUSE, EHeartEvent.FRESH_HOUSE], this.updatePanel);
            ElementHeartControl.getInstance().reqContainer(ElementLocateType.HOUSE);
            return;
        }// end function

        private function remvoeFromStage(event:Event) : void
        {
            this._data.removeEvtListeners([EHeartEvent.ADD_HOUSE, EHeartEvent.DELETE_HOUSE, EHeartEvent.FRESH_HOUSE], this.updatePanel);
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
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            switch(event.type)
            {
                case EHeartEvent.ADD_HOUSE:
                {
                    _loc_2 = event.obj;
                    _loc_3 = this._bagContainer.getContent(_loc_2.index);
                    if (_loc_3)
                    {
                        _loc_3.setInfo(_loc_2);
                    }
                    break;
                }
                case EHeartEvent.DELETE_HOUSE:
                {
                    _loc_2 = event.obj;
                    _loc_3 = this._bagContainer.getContent(_loc_2.index);
                    if (_loc_3)
                    {
                        _loc_3.setInfo(null);
                    }
                    break;
                }
                case EHeartEvent.FRESH_HOUSE:
                {
                    _loc_4 = 0;
                    while (_loc_4 < this.maxGrid())
                    {
                        
                        _loc_3 = this._bagContainer.getContent(_loc_4);
                        _loc_3.setInfo(null);
                        _loc_4++;
                    }
                    for each (_loc_5 in event.obj)
                    {
                        
                        _loc_3 = this._bagContainer.getContent(_loc_5.index);
                        if (_loc_3)
                        {
                            _loc_3.setInfo(_loc_5);
                        }
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

        private function maxGrid() : int
        {
            var _loc_1:* = ElementHeartData.MAX_HOUSE_NUM;
            _loc_1 = _loc_1 < 63 ? (63) : (Math.ceil(_loc_1 / 7) * 7);
            return _loc_1;
        }// end function

        override public function close() : void
        {
            super.close();
            this.pick = false;
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

    }
}
