package com.game.backpack.view.itemrenderers
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.backpack.events.*;
    import com.game.backpack.util.*;
    import com.game.operationpanel.event.*;
    import com.game.store.control.*;
    import com.game.store.events.*;
    import com.greensock.*;
    import com.manager.*;
    import com.manager.cd.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.utils.*;
    import interfaces.*;

    public class Itemrenderer extends DragBaseItem
    {
        protected var _parent:BaseSprite;
        protected var _gridId:int;
        protected var _status:int = 1;
        protected var _isMenu:Boolean = true;
        protected var _isDrag:Boolean = true;
        private var _icon:Bitmap;
        public var isEmpty:Boolean;
        private var _statusImg:Image;
        protected var _cdMask:CDMask;
        private var _lostTimeId:int;
        private var _clickTime:int;
        private var _priTimer:int;
        public static var LOCKED_TIPS:String = LanguageCfgObj.getInstance().getByIndex("10372");
        public static var OPENNED_TIPS:String = LanguageCfgObj.getInstance().getByIndex("11676");
        public static var OPENNING_TIPS:String = LanguageCfgObj.getInstance().getByIndex("11677");

        public function Itemrenderer(param1:String = "backpackbox_bg")
        {
            super(param1);
            setWH(46, 46);
            if (_backImage)
            {
                _backImage.x = 1;
                _backImage.y = 1;
            }
            buttonMode = true;
            mouseChildren = false;
            _image.move(2, 2);
            this._statusImg = new Image();
            this._statusImg.x = 3;
            this._statusImg.y = 3;
            addChild(this._statusImg);
            this.status = Params.CELL_NORMAL;
            return;
        }// end function

        override public function get info()
        {
            return _info;
        }// end function

        public function set info(param1) : void
        {
            _info = param1;
            this.setInfo(_info);
            return;
        }// end function

        public function addListener() : void
        {
            if (_info)
            {
                if (this._isMenu)
                {
                    addEvtListener(MouseEvent.CLICK, this.__click);
                    addEvtListener("rightClick", this.__rightClick);
                }
                else
                {
                    removeEvtListener(MouseEvent.CLICK, this.__click);
                    removeEvtListener("rightClick", this.__rightClick);
                }
                if (this._isDrag)
                {
                    addEvtListener(MouseEvent.MOUSE_DOWN, __mouseDown);
                }
                else
                {
                    removeEvtListener(MouseEvent.MOUSE_DOWN, __mouseDown);
                }
            }
            else
            {
                if (this._isDrag)
                {
                    removeEvtListener(MouseEvent.MOUSE_DOWN, __mouseDown);
                }
                if (this._isMenu)
                {
                    removeEvtListener(MouseEvent.CLICK, this.__click);
                    removeEvtListener("rightClick", this.__rightClick);
                }
            }
            return;
        }// end function

        public function get isDrag() : Boolean
        {
            return this._isDrag;
        }// end function

        public function setCD(param1:int, param2:int) : void
        {
            if (this._cdMask == null)
            {
                this._cdMask = new CDMask(_w - 2, _h - 2, true);
                this._cdMask.mouseEnabled = false;
            }
            if (this._cdMask.parent == null)
            {
                this._cdMask.x = 1;
                this._cdMask.y = 1;
                addChild(this._cdMask);
            }
            this._cdMask.setCD(param1, param2);
            return;
        }// end function

        public function set isDrag(param1:Boolean) : void
        {
            this._isDrag = param1;
            return;
        }// end function

        public function get isMenu() : Boolean
        {
            return this._isMenu;
        }// end function

        public function set isMenu(param1:Boolean) : void
        {
            this._isMenu = param1;
            return;
        }// end function

        public function get accpetKey() : Array
        {
            return _accpetKey;
        }// end function

        public function set accpetKey(param1:Array) : void
        {
            _accpetKey = param1;
            return;
        }// end function

        public function get gridId() : int
        {
            return this._gridId;
        }// end function

        public function set gridId(param1:int) : void
        {
            this._gridId = param1;
            return;
        }// end function

        public function get status() : int
        {
            return this._status;
        }// end function

        private function changeStatusIndex() : void
        {
            if (this._statusImg)
            {
                if (this._cdMask && this._cdMask.parent)
                {
                    setChildIndex(this._statusImg, numChildren - 2);
                }
                else
                {
                    setChildIndex(this._statusImg, (numChildren - 1));
                }
            }
            return;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
            if (this._status == Params.CELL_OPENNING)
            {
                this._statusImg.load(Params.ICON_PATH + "bagunlock.png");
                this.changeStatusIndex();
            }
            else if (this._status == Params.CELL_OPENED)
            {
                this._statusImg.load(Params.ICON_PATH + "bagunlock.png");
                this.changeStatusIndex();
            }
            else if (this._status == Params.CELL_LOCKED)
            {
                this._statusImg.load(Params.ICON_PATH + "baglock.png");
                this.changeStatusIndex();
            }
            else if (this._statusImg.parent)
            {
                this._statusImg.dispose();
            }
            return;
        }// end function

        public function get place() : String
        {
            return _place;
        }// end function

        public function set place(param1:String) : void
        {
            _place = param1;
            return;
        }// end function

        public function get parentContainer() : BaseSprite
        {
            return this._parent;
        }// end function

        public function set parentContainer(param1:BaseSprite) : void
        {
            this._parent = param1;
            return;
        }// end function

        override public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            if (_info != null)
            {
                (_info as PropInfo).removeEvtListener(PropEvent.UPDATE_FIGHTNUMBER, this.__updateFightNumber);
            }
            _info = param1 as PropInfo;
            clearTimeout(this._lostTimeId);
            if (_info)
            {
                super.setInfo(param1, param2);
                if (_info is EquipmentInfo)
                {
                    (_info as EquipmentInfo).addEvtListener(PropEvent.UPDATE_FIGHTNUMBER, this.__updateFightNumber);
                }
            }
            else
            {
                super.setInfo(param1, param2);
                if (this._status == Params.CELL_NORMAL)
                {
                    ItemTips.dispose(this);
                    if (this._statusImg)
                    {
                        this._statusImg.dispose();
                    }
                    filters = [];
                }
            }
            this.repaintExpTips();
            this.addListener();
            if (this._status != Params.CELL_NORMAL)
            {
                addEvtListener(MouseEvent.CLICK, this.__click);
            }
            this.desideIcon();
            var _loc_3:* = this.getLostTime();
            var _loc_4:* = ToolKit.getServerTime();
            if (_info && _info.lostTime && _loc_3 == false)
            {
                setTimeout(this.lostTimeDecide, _info.lostTime * 1000 - _loc_4);
            }
            this.decideStatus();
            this.decideGrayMatrix();
            return;
        }// end function

        private function lostTimeDecide() : void
        {
            clearTimeout(this._lostTimeId);
            this.decideGrayMatrix();
            this.desideIcon();
            return;
        }// end function

        private function decideStatus() : void
        {
            var _loc_1:* = false;
            if (this.place == Params.ITEM_PLACE_BACKPACK && this._status == Params.CELL_NORMAL)
            {
                _loc_1 = false;
                if (_info && (_info.isbind || _info.unInteractive) && (BackPackControl.getInstance().mode == BackPackControl.TRANSCATION || BackPackControl.getInstance().mode == BackPackControl.ADDTOSTALLS))
                {
                    _loc_1 = true;
                }
                if (_loc_1)
                {
                    this._statusImg.load(Params.ICON_PATH + "baglock.png");
                    this.changeStatusIndex();
                }
                else
                {
                    this._statusImg.dispose();
                }
            }
            return;
        }// end function

        public function isNeedToGray() : Boolean
        {
            var _loc_2:* = false;
            var _loc_1:* = false;
            if (this.info && this.info is PropInfo)
            {
                _loc_2 = this.getLostTime();
                if (this.place == Params.ITEM_PLACE_BACKPACK || this.place == Params.ITEM_PLACE_STORE)
                {
                    if (_info && (_info.unInteractive || _info.isbind) && (BackPackControl.getInstance().mode == BackPackControl.TRANSCATION || BackPackControl.getInstance().mode == BackPackControl.ADDTOSTALLS))
                    {
                        _loc_1 = true;
                    }
                    if (_loc_2)
                    {
                        _loc_1 = true;
                    }
                }
            }
            return _loc_1;
        }// end function

        private function decideGrayMatrix() : void
        {
            var _loc_1:* = this.isNeedToGray();
            if (_loc_1)
            {
                filters = [FrameworkGlobal.colorMat];
            }
            else
            {
                this.filters = [];
            }
            return;
        }// end function

        private function __updateFightNumber(event:PropEvent = null) : void
        {
            this.desideIcon();
            return;
        }// end function

        private function removeDragFilter() : void
        {
            var _loc_1:* = filters;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                if (_loc_1[_loc_2] is GlowFilter)
                {
                    _loc_1.splice(_loc_2, 1);
                    _loc_2 = _loc_2 - 1;
                }
                _loc_2++;
            }
            filters = _loc_1;
            return;
        }// end function

        public function setBind(param1:Boolean) : void
        {
            if (_info)
            {
                if (param1)
                {
                    this._statusImg.load(Params.ICON_PATH + "baglock.png");
                    this.changeStatusIndex();
                }
                else
                {
                    this._statusImg.dispose();
                }
                this.setLocked(param1);
            }
            return;
        }// end function

        public function getLostTime() : Boolean
        {
            var _loc_2:* = NaN;
            var _loc_1:* = false;
            if (_info && _info is PropInfo)
            {
                _loc_2 = ToolKit.getServerTime();
                if (_info.lostTime != 0 && _info.lostTime * 1000 <= _loc_2)
                {
                    _loc_1 = true;
                }
            }
            else
            {
                _loc_1 = false;
            }
            return _loc_1;
        }// end function

        public function desideIcon() : void
        {
            var _loc_1:* = this.getLostTime();
            var _loc_2:* = 0;
            if (_loc_1)
            {
                this.needIcon = 0;
            }
            else
            {
                if (_info is EquipmentInfo)
                {
                    _loc_2 = EquipUtil.compareEquip(_info as EquipmentInfo);
                }
                this.needIcon = _loc_2;
            }
            return;
        }// end function

        public function set needIcon(param1:int) : void
        {
            if (param1 == 0)
            {
                if (this._icon)
                {
                    if (this._icon.parent)
                    {
                        this._icon.parent.removeChild(this._icon);
                    }
                    this._icon = null;
                }
            }
            else
            {
                if (this._icon)
                {
                    if (this._icon.parent)
                    {
                        this._icon.parent.removeChild(this._icon);
                    }
                    this._icon = null;
                }
                if (param1 == 1)
                {
                    this._icon = ToolKit.getNewDO("equipvalueup") as Bitmap;
                }
                else if (param1 == 2)
                {
                    this._icon = ToolKit.getNewDO("equipvaluedown") as Bitmap;
                }
                this._icon.x = _backImage.x + _backImage.width - this._icon.width - 2;
                this._icon.y = _backImage.y + _backImage.height - this._icon.height - 2;
                addChild(this._icon);
            }
            return;
        }// end function

        override protected function __rightClick(event:MouseEvent) : void
        {
            if (this.place == Params.ITEM_PLACE_BACKPACK && _info && _info.unInteractive || DragManager.getInstance().inDrag)
            {
                event.stopImmediatePropagation();
                return;
            }
            this.doOper();
            return;
        }// end function

        private function doOper() : void
        {
            if (_place == Params.ITEM_PLACE_BACKPACK && StoreControl.getInstance().view.parent)
            {
                StoreDispatcher.dispatch().dispatchEvent(new StoreEvent(StoreEvent.ITEM_MOVE_TO_STORE, {info:_info}));
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && BackPackControl.getInstance().isSell())
            {
                dispatchEvent(new BackpackEvent(BackpackEvent.BOX_SELL, _info, true));
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && BackPackControl.getInstance().isTranscation())
            {
                dispatchEvent(new BackpackEvent(BackpackEvent.BOX_TRANSCATION, this, true));
                return;
            }
            if (_info is EquipmentInfo)
            {
                BackPackControl.getInstance().equip(_info as EquipmentInfo);
            }
            else
            {
                BackPackControl.getInstance().useItem(_info, 1);
            }
            return;
        }// end function

        override protected function __doDrag(event:MouseEvent) : void
        {
            if (DragManager.getInstance().inDrag || _info == null)
            {
                return;
            }
            if (this.place == Params.ITEM_PLACE_BACKPACK && _info.unInteractive)
            {
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && BackPackControl.getInstance().isAddToStalls() && BackPackControl.getInstance().fastSelect)
            {
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && BackPackControl.getInstance().isTranscation() && BackPackControl.getInstance().fastSelect)
            {
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && BackPackControl.getInstance().isSell() && BackPackControl.getInstance().fastSelect)
            {
                return;
            }
            removeEvtListener(MouseEvent.CLICK, this.__click);
            super.__doDrag(event);
            return;
        }// end function

        override public function dragEnter() : void
        {
            var _loc_1:* = this.isNeedToGray();
            if (!_loc_1)
            {
                filters = this.filters.concat(FrameworkGlobal.ORANGE_FILTER);
                _image.alpha = 0.3;
            }
            return;
        }// end function

        override public function dragOut() : void
        {
            this.removeDragFilter();
            _image.alpha = 1;
            return;
        }// end function

        public function setLocked(param1:Boolean) : void
        {
            if (_info && _info is PropInfo)
            {
                (_info as PropInfo).unInteractive = param1;
            }
            this.decideGrayMatrix();
            return;
        }// end function

        override public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            var _loc_4:* = null;
            if (this.place == Params.ITEM_PLACE_BACKPACK && param2.getKey() == Params.ITEM_PLACE_BACKPACK)
            {
                _loc_4 = new Object();
                _loc_4.itemId = param1.itemId;
                _loc_4.item = param2;
                _loc_4.targetItem = param3;
                _loc_4.num = param1.num;
                if (_info)
                {
                    _loc_4.toGridId = _info.gridId;
                }
                else
                {
                    _loc_4.toGridId = this._gridId;
                }
                dispatchEvent(new BackpackEvent(BackpackEvent.BOX_MOVE, _loc_4, true));
            }
            if (this.place == Params.ITEM_PLACE_SHORTCUT_AREA)
            {
                _loc_4 = new Object();
                _loc_4.info = param1;
                _loc_4.item = param2;
                _loc_4.targetItem = param3;
                OperationDispatch.dispatch().dispatchEvent(new OperationEvent(OperationEvent.SKILL_BOX_MOVE, _loc_4));
            }
            if (this.place == Params.ITEM_PLACE_BACKPACK && param2.getKey() == Params.ITEM_PLACE_STORE)
            {
                _loc_4 = new Object();
                _loc_4.info = param1;
                _loc_4.item = param2;
                _loc_4.targetItem = param3;
                StoreDispatcher.dispatch().dispatchEvent(new StoreEvent(StoreEvent.ITEM_MOVE_TO_BACKPACK, _loc_4));
            }
            return;
        }// end function

        public function update() : void
        {
            if (_info)
            {
                drawCount();
            }
            else
            {
                drawCount(false);
            }
            this.desideIcon();
            return;
        }// end function

        override public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            var _loc_3:* = null;
            if (!param1)
            {
                if (this.place == Params.ITEM_PLACE_BACKPACK)
                {
                    _loc_3 = new Object();
                    _loc_3.point = param2;
                    _loc_3.info = _info;
                    if (BackPackControl.getInstance().mode == BackPackControl.NORMAL)
                    {
                        dispatchEvent(new DragEvent(DragEvent.DRAG_FALSE, _loc_3, true));
                    }
                }
                if (this.place == Params.ITEM_PLACE_SHORTCUT_AREA)
                {
                    OperationDispatch.dispatch().dispatchEvent(new OperationEvent(OperationEvent.SKILL_BOX_REMOVE, this.info));
                }
                this._clickTime = setTimeout(this.addBackListener, 100);
            }
            _image.alpha = 1;
            filters = [];
            return;
        }// end function

        private function addBackListener() : void
        {
            this.addListener();
            if (this._status != Params.CELL_NORMAL)
            {
                addEvtListener(MouseEvent.CLICK, this.__click);
            }
            return;
        }// end function

        override public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            if (!visible)
            {
                return false;
            }
            return acceptKey().indexOf(param1.getKey()) != -1;
        }// end function

        public function clearCDMask() : void
        {
            if (this._cdMask && this._cdMask.parent)
            {
                this._cdMask.parent.removeChild(this._cdMask);
                this._cdMask.setCD(0, 1);
                this._cdMask = null;
            }
            return;
        }// end function

        public function repaintExpTips() : void
        {
            var _loc_3:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = new CdTipsInfo();
            var _loc_2:* = BackpackOpenCfgObj.getInstance().getCost("1_" + this._gridId);
            var _loc_4:* = LevelExpCfgObj.getInstance().getQ_rexp(UserObj.getInstance().playerInfo.job, UserObj.getInstance().playerInfo.level);
            if (this._status == Params.CELL_NORMAL)
            {
                if (_info == null)
                {
                    ItemTips.dispose(this);
                }
                this.clearCDMask();
            }
            else if (this._status == Params.CELL_OPENNING)
            {
                _loc_3 = _loc_2.q_time;
                _loc_5 = Number(_loc_2.q_coe * _loc_4) + Number(_loc_2.q_exp);
                _loc_6 = CDManager.getInstance().getCD(CDTypes.BACKPACK_OPEN);
                _loc_7 = OPENNED_TIPS.replace("%c", _loc_5);
                _loc_8 = OPENNING_TIPS.replace("%c", _loc_5);
                _loc_1.template = _loc_8;
                _loc_1.endTemplate = _loc_7;
                _loc_1.endTime = _loc_6[0] + ToolKit.getServerTime();
                ItemTips.create(this, _loc_1, TimeStringTips);
            }
            else if (this._status == Params.CELL_OPENED)
            {
                this.clearCDMask();
                _loc_3 = _loc_2.q_time;
                _loc_5 = Number(_loc_2.q_coe * _loc_4) + Number(_loc_2.q_exp);
                _loc_6 = CDManager.getInstance().getCD(CDTypes.BACKPACK_OPEN);
                _loc_7 = OPENNED_TIPS.replace("%c", _loc_5);
                _loc_8 = OPENNING_TIPS.replace("%c", _loc_5);
                _loc_7 = OPENNED_TIPS.replace("%c", _loc_5);
                _loc_1.template = _loc_7;
                ItemTips.create(this, _loc_1, TimeStringTips);
            }
            else if (this._status == Params.CELL_LOCKED)
            {
                _loc_3 = _loc_2.q_time;
                _loc_5 = Number(_loc_2.q_coe * _loc_4) + Number(_loc_2.q_exp);
                _loc_1.template = LOCKED_TIPS.replace("%c", _loc_5);
                ItemTips.create(this, _loc_1, TimeStringTips);
            }
            else
            {
                this.clearCDMask();
            }
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            if (param1)
            {
                filters = [FrameworkGlobal.ORANGE_FILTER];
            }
            else
            {
                filters = [];
            }
            return;
        }// end function

        override protected function singleClick(param1:int, param2:int) : void
        {
            this._priTimer = 0;
            if (_info && _info.itemModelId != 0)
            {
                BackPackControl.getInstance().itemPopUp(_info, this, param1, param2);
            }
            return;
        }// end function

        override protected function doDoubleClick() : void
        {
            TweenLite.killDelayedCallsTo(this.singleClick);
            if (_info == null)
            {
                return;
            }
            this.doOper();
            return;
        }// end function

        override protected function __click(event:MouseEvent) : void
        {
            var _loc_2:* = getTimer();
            if (this.place == Params.ITEM_PLACE_BACKPACK && _info && _info.unInteractive)
            {
                event.stopImmediatePropagation();
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && BackPackControl.getInstance().isSell() && BackPackControl.getInstance().fastSelect)
            {
                if (_info)
                {
                    dispatchEvent(new BackpackEvent(BackpackEvent.BOX_SELL, _info, true));
                }
                event.stopImmediatePropagation();
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && BackPackControl.getInstance().isTranscation() && BackPackControl.getInstance().fastSelect)
            {
                if (_info)
                {
                    dispatchEvent(new BackpackEvent(BackpackEvent.BOX_TRANSCATION, this, true));
                }
                event.stopImmediatePropagation();
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && BackPackControl.getInstance().isAddToStalls() && BackPackControl.getInstance().fastSelect)
            {
                if (_info)
                {
                    dispatchEvent(new BackpackEvent(BackpackEvent.BOX_ADDTOSTALLS, this, true));
                }
                event.stopImmediatePropagation();
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && this._status == Params.CELL_OPENED)
            {
                dispatchEvent(new BackpackEvent(BackpackEvent.BOX_OPEN, this, true));
                return;
            }
            if (_place == Params.ITEM_PLACE_BACKPACK && (this._status == Params.CELL_OPENNING || this._status == Params.CELL_LOCKED))
            {
                dispatchEvent(new BackpackEvent(BackpackEvent.BOX_OPEN_DIAMOND, this, true));
                return;
            }
            if (_loc_2 - this._priTimer < 300)
            {
                this.doDoubleClick();
                this._priTimer = 0;
            }
            else
            {
                this._priTimer = _loc_2;
                TweenLite.delayedCall(0.3, this.singleClick, [mouseX, mouseY]);
            }
            return;
        }// end function

    }
}
