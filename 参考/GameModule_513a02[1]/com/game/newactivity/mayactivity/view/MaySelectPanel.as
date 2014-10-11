package com.game.newactivity.mayactivity.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.backpack.model.*;
    import com.game.equipstreng.view.*;
    import com.game.newactivity.control.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class MaySelectPanel extends BaseBox
    {
        private var mcMatarilBg1:MovieClip;
        private var mcMatarilBg2:MovieClip;
        private var mcMataril1:MovieClip;
        private var mcMataril2:MovieClip;
        private var mcResult:MovieClip;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var mc5:MovieClip;
        private var mc6:MovieClip;
        private var btn:BaseButton;
        private var closeBtn:BaseButton;
        private var id1:long;
        private var id2:long;
        public var goodID:int;
        public var pos:int;
        private var _isDrog:Boolean;
        private var _dragimage:IconItem;

        public function MaySelectPanel(param1 = "maySelectPanel", param2:String = null)
        {
            initComponentUI(param1);
            this.displayReady();
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            this.initUI();
            this.addEvent();
            return;
        }// end function

        private function initUI() : void
        {
            this.mcMatarilBg1 = getDisplayChildByName("mcMatarilBg1");
            this.mcMatarilBg1.tempname = "mcMatarilBg1";
            this.mcMatarilBg2 = getDisplayChildByName("mcMatarilBg2");
            this.mcMatarilBg2.tempname = "mcMatarilBg2";
            this.mcMataril1 = getDisplayChildByName("mcMataril1");
            this.mcMataril2 = getDisplayChildByName("mcMataril2");
            this.mcResult = getDisplayChildByName("mcResult");
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.mc3 = getDisplayChildByName("mc3");
            this.mc4 = getDisplayChildByName("mc4");
            this.mc5 = getDisplayChildByName("mc5");
            this.mc6 = getDisplayChildByName("mc6");
            this.btn = new BaseButton(getDisplayChildByName("btn"));
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.autoSet();
            this.update();
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.clear();
            }
            return;
        }// end function

        public function clear() : void
        {
            this.id1 = null;
            this.id2 = null;
            ToolKit.clearMcChild(this.mcMataril1);
            ToolKit.clearMcChild(this.mcMataril2);
            return;
        }// end function

        private function addEvent() : void
        {
            this.btn.addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.btn:
                {
                    if (this.id1 && this.id2)
                    {
                        NewActivityControl.getInstance().reqExchangeJewewlry(this.id1, this.id2, this.goodID);
                    }
                    else
                    {
                        _loc_2 = ItemCfgObj.getInstance().getItemCfg(this.goodID);
                        if (_loc_2 && _loc_2.q_kind == Params.NICKLACE)
                        {
                            Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12110"));
                        }
                        else if (_loc_2 && (_loc_2.q_kind == Params.RING1 || _loc_2.q_kind == Params.RING2))
                        {
                            Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12111"));
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

        public function update() : void
        {
            var _loc_3:* = 0;
            var _loc_6:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < 6)
            {
                
                ToolKit.clearMcChild(this["mc" + (_loc_1 + 1)]);
                _loc_1++;
            }
            var _loc_2:* = BackpackObj.getInstance().getJewelryByItemPos(this.pos);
            _loc_3 = 0;
            _loc_1 = 0;
            while (_loc_2 && _loc_1 < _loc_2.length && _loc_1 < 6)
            {
                
                if (!_loc_2[_loc_1].itemId.equal(this.id1) && !_loc_2[_loc_1].itemId.equal(this.id2))
                {
                    _loc_6 = new EquipImage();
                    _loc_6.setInfo(_loc_2[_loc_1], false, "", 40, 40);
                    _loc_6.image.name = "" + _loc_2[_loc_1].itemModelId;
                    _loc_6.x = 3;
                    _loc_6.y = 3;
                    this["mc" + (_loc_3 + 1)].addChild(_loc_6);
                    _loc_6.addEventListener(MouseEvent.MOUSE_DOWN, this.__startDrag);
                    _loc_3++;
                }
                _loc_1++;
            }
            var _loc_4:* = PropUtil.createItemByCfg(this.goodID);
            if (this.goodID != 0)
            {
                _loc_4.q_kind = 13;
                (_loc_4 as EquipmentInfo).q_set_uniquelevel = 3;
                _loc_4.q_quality_lv = 6;
                _loc_4.q_name = LanguageCfgObj.getInstance().getByIndex("11786") + _loc_4.q_name;
            }
            var _loc_5:* = new IconItem("");
            _loc_5.setWH(56, 56);
            _loc_5.setImageSize(56, 56);
            _loc_5.setInfo(_loc_4);
            _loc_5.x = 5;
            _loc_5.y = 5;
            ToolKit.clearMcChild(this.mcResult);
            this.mcResult.addChild(_loc_5);
            return;
        }// end function

        protected function __startMove(event:MouseEvent) : void
        {
            if (this._isDrog)
            {
                this._dragimage.x = event.stageX;
                this._dragimage.y = event.stageY;
            }
            return;
        }// end function

        private function autoSet() : void
        {
            var _loc_4:* = null;
            var _loc_1:* = BackpackObj.getInstance().getJewelryByItemPos(this.pos);
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_1 && _loc_3 < _loc_1.length && _loc_3 < 2)
            {
                
                ToolKit.clearMcChild(this["mcMataril" + (_loc_2 + 1)]);
                _loc_4 = new IconItem("");
                _loc_4.setWH(56, 56);
                _loc_4.setImageSize(56, 56);
                _loc_4.setInfo(_loc_1[_loc_3]);
                _loc_4.x = 6;
                _loc_4.y = 6;
                this["mcMataril" + (_loc_2 + 1)].addChild(_loc_4);
                this["id" + (_loc_3 + 1)] = _loc_1[_loc_3].itemId;
                _loc_2++;
                _loc_3++;
            }
            return;
        }// end function

        protected function __StopDrag(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = this.getObjectsUnderPoint(new Point(event.stageX, event.stageY));
            this._isDrog = false;
            FrameworkGlobal.stage.removeChild(this._dragimage);
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.__startMove);
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_UP, this.__StopDrag);
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3].parent && !(_loc_2[_loc_3].parent is IconItem) && _loc_2[_loc_3].parent.tempname == "mcMatarilBg1")
                {
                    ToolKit.clearMcChild(this.mcMataril1);
                    _loc_4 = new IconItem("");
                    _loc_4.setWH(56, 56);
                    _loc_4.setImageSize(56, 56);
                    _loc_4.setInfo(this._dragimage.info);
                    _loc_4.x = 6;
                    _loc_4.y = 6;
                    this.mcMataril1.addChild(_loc_4);
                    this.id1 = (this._dragimage.info as EquipmentInfo).itemId;
                }
                if (_loc_2[_loc_3].parent && !(_loc_2[_loc_3].parent is IconItem) && _loc_2[_loc_3].parent.tempname == "mcMatarilBg2")
                {
                    ToolKit.clearMcChild(this.mcMataril2);
                    _loc_4 = new IconItem("");
                    _loc_4.setWH(56, 56);
                    _loc_4.setImageSize(56, 56);
                    _loc_4.setInfo(this._dragimage.info);
                    _loc_4.x = 5;
                    _loc_4.y = 5;
                    this.mcMataril2.addChild(_loc_4);
                    this.id2 = (this._dragimage.info as EquipmentInfo).itemId;
                }
                _loc_3++;
            }
            this.update();
            return;
        }// end function

        protected function __startDrag(event:MouseEvent) : void
        {
            if (!this._dragimage)
            {
                this._dragimage = new IconItem("");
                this._dragimage.setWH(56, 56);
                this._dragimage.setImageSize(56, 56);
            }
            this._dragimage.setInfo(event.target.info);
            this._dragimage.name = event.target.name;
            this._dragimage.x = event.stageX;
            this._dragimage.y = event.stageY;
            FrameworkGlobal.stage.addChild(this._dragimage);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.__startMove);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_UP, this.__StopDrag);
            this._isDrog = true;
            return;
        }// end function

        public function setPos(param1:int, param2:int) : void
        {
            this.pos = param1;
            this.goodID = param2;
            if (UILoaded)
            {
                this.autoSet();
                this.update();
            }
            return;
        }// end function

    }
}
