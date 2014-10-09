package com.game.backpack.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.artifact.control.*;
    import com.game.backpack.control.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.backpack.view.itemrenderers.*;
    import com.game.guide.control.*;
    import com.game.mall.utils.*;
    import com.game.map.control.*;
    import com.game.player.events.*;
    import com.game.player.model.*;
    import com.game.protect.control.*;
    import com.game.protect.view.*;
    import com.game.shop.control.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.manager.cd.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class BackpackView extends Component
    {
        private var _boxes:Vector.<Itemrenderer>;
        private var _bagObj:BackpackObj;
        private var _totalTab:BaseButton;
        private var _equipTab:BaseButton;
        private var _diamondTab:BaseButton;
        private var _medicinalTab:BaseButton;
        private var _otherTab:BaseButton;
        private var _arrageBtn:BaseButton;
        private var _depotBtn:BaseButton;
        private var _shopBtn:BaseButton;
        private var _oneKeyBtn:BaseButton;
        private var _buttons:Buttons;
        private var _sort:String = "";
        private var _curPage:Vector.<PropInfo>;
        private var _rechargeBtn:BaseButton;
        private var _bagSp:Sprite;
        private var _bagContainer:HBox;
        private var _selectedItem:Itemrenderer;
        private var _backpackControl:BackPackControl;
        private var _goldTxt:TextField;
        private var _diamondTxt:TextField;
        private var _bindedDiamondTxt:TextField;
        private var _dragItem:Itemrenderer;
        private var _targetItem:Itemrenderer;
        private var _scrollpanel:ScrollPanel;
        private var _coinsp:CurrencyIcon;
        private var _diamondsp:CurrencyIcon;
        private var _binddiamondsp:CurrencyIcon;
        private var _bg:Sprite;
        private var _sellBtn:BaseButton;
        public var msgContainer:Sprite;
        private var btn_protect_highlock:BaseButton;
        private var highLockTips:MovieClip;
        private var _maxLen:int;
        private var _sellBorder:Sprite;
        private var _openFlicker:int;
        private var _shrinkItem:Itemrenderer;
        private var _openBox:Itemrenderer;
        private var _isSell:Boolean;
        private var _targetDragComplete:Boolean = false;
        private var _startDragComplete:Boolean = false;
        private var _dragItemNum:int;
        private var _dragComplete:int;
        private var _arrangeTimer:Timer;
        private static const ROW:int = 7;
        private static const TABLENGTH:int = 5;
        private static const ARRANGECOUNT:int = 5;

        public function BackpackView(param1 = null, param2:String = null)
        {
            this._boxes = new Vector.<Itemrenderer>;
            super(param1, param2);
            BackPackControl.getInstance();
            return;
        }// end function

        override protected function initComponentUI(param1, param2 = null) : void
        {
            super.initComponentUI(param1, param2);
            this.initUI();
            this.addListener();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = 0;
            this._buttons = new Buttons();
            this._totalTab = new BaseButton(getDisplayChildByName("btn_total"), true);
            this._equipTab = new BaseButton(getDisplayChildByName("btn_equip"), true);
            this._diamondTab = new BaseButton(getDisplayChildByName("btn_diamond"), true);
            this._medicinalTab = new BaseButton(getDisplayChildByName("btn_medicinal"), true);
            this._otherTab = new BaseButton(getDisplayChildByName("btn_other"), true);
            this._otherTab.setText(LanguageCfgObj.getInstance().getByIndex("10344"));
            this._medicinalTab.setText(LanguageCfgObj.getInstance().getByIndex("10345"));
            this._equipTab.setText(LanguageCfgObj.getInstance().getByIndex("10346"));
            this._diamondTab.setText(LanguageCfgObj.getInstance().getByIndex("10347"));
            this._totalTab.setText(LanguageCfgObj.getInstance().getByIndex("10348"));
            this._buttons.horizontal = true;
            this._buttons.intervalX = 1;
            this._buttons.intervalY = 0;
            this._buttons.move(20, 51);
            this._buttons.add(this._totalTab);
            this._buttons.add(this._equipTab);
            this._buttons.add(this._diamondTab);
            this._buttons.add(this._medicinalTab);
            this._buttons.add(this._otherTab);
            this._bagSp = new Sprite();
            this._bagContainer = new HBox();
            this._bagContainer.intervalX = 1;
            this._bagContainer.intervalY = 2;
            this._bagContainer.oneRow = ROW;
            this._bagContainer.y = 4;
            this._bagSp.addChild(this._bagContainer);
            this._scrollpanel = new ScrollPanel(350, 338);
            this._scrollpanel.content = this._bagSp;
            this._scrollpanel.move(16, 80);
            addChild(this._scrollpanel);
            addChild(this._buttons);
            this._arrageBtn = new BaseButton(getDisplayChildByName("btn_arrange"));
            this._oneKeyBtn = new BaseButton(getDisplayChildByName("btn_onekey"));
            this._depotBtn = new BaseButton(getDisplayChildByName("btn_depot"));
            this._shopBtn = new BaseButton(getDisplayChildByName("btn_shop"));
            this._sellBtn = new BaseButton(getDisplayChildByName("btn_sell"));
            this._rechargeBtn = new BaseButton(getDisplayChildByName("btn_recharge"));
            this._bindedDiamondTxt = getDisplayChildByName("txt_bindeddiamond");
            this._bg = getDisplayChildByName("bg");
            this._diamondTxt = getDisplayChildByName("txt_diamond");
            this._goldTxt = getDisplayChildByName("txt_gold");
            this._depotBtn.setText(LanguageCfgObj.getInstance().getByIndex("10349"), true);
            this._shopBtn.setText(LanguageCfgObj.getInstance().getByIndex("10350"), true);
            this._oneKeyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10351"));
            this._arrageBtn.setText(LanguageCfgObj.getInstance().getByIndex("10352"));
            this._sellBtn.setText(LanguageCfgObj.getInstance().getByIndex("10353"));
            this._backpackControl = BackPackControl.getInstance();
            this._backpackControl.backpackview = this;
            this._coinsp = IconUtil.getIconSp(CostType.COIN);
            this._diamondsp = IconUtil.getIconSp(CostType.GOLD);
            this._binddiamondsp = IconUtil.getIconSp(CostType.BINDGOLD);
            this._coinsp.x = this._goldTxt.x - this._coinsp.width - 3;
            this._coinsp.y = this._goldTxt.y;
            this._diamondsp.x = this._diamondTxt.x - this._diamondsp.width - 3;
            this._diamondsp.y = this._diamondTxt.y;
            this._binddiamondsp.x = this._bindedDiamondTxt.x - this._binddiamondsp.width - 3;
            this._binddiamondsp.y = this._bindedDiamondTxt.y;
            StringTip.create(this._goldTxt, CurrencyIcon.COIN);
            StringTip.create(this._diamondTxt, CurrencyIcon.GOLD);
            StringTip.create(this._bindedDiamondTxt, CurrencyIcon.BINDGOLD);
            StringTip.create(this._sellBtn, LanguageCfgObj.getInstance().getByIndex("10354"));
            StringTip.create(this._arrageBtn, LanguageCfgObj.getInstance().getByIndex("10355"));
            display.addChild(this._coinsp);
            display.addChild(this._diamondsp);
            display.addChild(this._binddiamondsp);
            ProtectControl.getInstance().lockButton = new ProtectLockButton(getDisplayChildByName("btn_protect_locked"), getDisplayChildByName("btn_protect_unlocked"), this.onProtectLockButtonVisibleChange);
            this.msgContainer = new Sprite();
            this.msgContainer.x = 10;
            this.msgContainer.y = 421;
            addChild(this.msgContainer);
            this.btn_protect_highlock = new BaseButton(getDisplayChildByName("btn_protect_highlock"));
            this.highLockTips = getDisplayChildByName("highLockTips");
            this.highLockTips.parent.removeChild(this.highLockTips);
            this.highLockTips.visible = false;
            return;
        }// end function

        private function addListener() : void
        {
            this._buttons.addEvtListener(Event.CHANGE, this.onTabChange);
            this._arrageBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._shopBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._depotBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._oneKeyBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._rechargeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._sellBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            var _loc_1:* = UserObj.getInstance().playerInfo;
            _loc_1.addEvtListener(RoleEvent.UPDATE_GOLD, this.__updateGold);
            _loc_1.addEvtListener(RoleEvent.UPDATE_BINDGOLD, this.__updateBindedDiamond);
            _loc_1.addEvtListener(RoleEvent.UPDATE_MONEY, this.__updateMoney);
            addEvtListener(BackpackEvent.BOX_SELECTED, this.__boxSelected, true);
            this._bagObj = BackpackObj.getInstance();
            this._bagObj.addEvtListener(BackpackEvent.BOX_REMOVE, this.__itemRemove);
            this._bagObj.addEvtListener(BackpackEvent.BOX_CHANGE, this.__boxChange);
            this._bagObj.addEvtListener(BackpackEvent.BOX_ADD, this.__itemAdd);
            addEvtListener(BackpackEvent.BOX_TRANSCATION, this.__itemTranscation);
            addEvtListener(BackpackEvent.BOX_SELL, this.__itemSell);
            addEvtListener(BackpackEvent.BOX_MOVE, this.__itemMove);
            addEvtListener(DragEvent.DRAG_FALSE, this.__itemDragFalse);
            addEvtListener(BackpackEvent.BOX_OPEN, this.__openCell);
            addEvtListener(BackpackEvent.BOX_OPEN_DIAMOND, this.__openCellDiamond);
            addEvtListener(BackpackEvent.BOX_ADDTOSTALLS, this.__addToStalls);
            EquipsObj.getInstance().addEvtListeners([EquipEvent.TAKE_OFF, EquipEvent.WEAR, EquipEvent.EQUIPSTRENTH], this.__recountValue);
            FrameworkGlobal.addMsgListen(GameEvent.CD_CHANGE, this.__cdChange);
            this.btn_protect_highlock.addEventListener(MouseEvent.MOUSE_OVER, this.__over, false, 0, false);
            this.btn_protect_highlock.addEventListener(MouseEvent.MOUSE_OUT, this.__out, false, 0, false);
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            this.highLockTips.visible = true;
            this.addChild(this.highLockTips);
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            this.highLockTips.visible = false;
            if (this.highLockTips.parent)
            {
                this.highLockTips.parent.removeChild(this.highLockTips);
            }
            return;
        }// end function

        private function __cdChange(event:GameEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._maxLen)
            {
                
                if (this._boxes[_loc_2].info && this._boxes[_loc_2].info.q_type == ItemType.MEDICINE)
                {
                    _loc_3 = CDManager.getInstance().getCD(CDTypes.DRUG, this._boxes[_loc_2].info.itemModelId, this._boxes[_loc_2].info.q_cooldown_level);
                    this._boxes[_loc_2].setCD(_loc_3[0], _loc_3[1]);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function onProtectLockButtonVisibleChange(param1:Boolean) : void
        {
            if (param1)
            {
                this._shopBtn.x = 16;
                this._depotBtn.x = 97;
                this._oneKeyBtn.x = 178;
                this._arrageBtn.x = 263;
                this._sellBtn.x = 300;
            }
            else
            {
                this._shopBtn.x = 18;
                this._depotBtn.x = 103;
                this._oneKeyBtn.x = 189;
                this._arrageBtn.x = 283;
                this._sellBtn.x = 323;
            }
            return;
        }// end function

        public function arrangBoxes() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            this._maxLen = this.getMaxLen();
            _loc_1 = 0;
            while (_loc_1 < this._maxLen)
            {
                
                _loc_2 = new Itemrenderer();
                _loc_2.place = Params.ITEM_PLACE_BACKPACK;
                _loc_2.gridId = _loc_1 + 1;
                _loc_2.accpetKey = [Params.ITEM_PLACE_BACKPACK, Params.ITEM_PLACE_ROLEPANEL, Params.ITEM_PLACE_STORE];
                this._bagContainer.add(_loc_2, false, 0, 0);
                this._boxes.push(_loc_2);
                _loc_1++;
            }
            this._scrollpanel.updateThumb();
            if (BackpackObj.getInstance().info.openningGridId)
            {
                this.dealCellStatus(BackpackObj.getInstance().info.openningGridId);
            }
            return;
        }// end function

        public function getMaxLen() : int
        {
            var _loc_1:* = BackpackObj.getInstance().info.openningGridId;
            if (_loc_1 == 0)
            {
                _loc_1 = BackpackObj.CAPACITY;
            }
            var _loc_2:* = Math.ceil(_loc_1 / ROW) * ROW;
            _loc_2 = _loc_2 > BackpackObj.CAPACITY ? (BackpackObj.CAPACITY) : (_loc_2);
            return _loc_2;
        }// end function

        private function __recountValue(event:EquipEvent) : void
        {
            var _loc_2:* = 0;
            if (this._sort == BackpackObj.TOTAL)
            {
                _loc_2 = 0;
                while (_loc_2 < this._boxes.length)
                {
                    
                    this._boxes[_loc_2].desideIcon();
                    _loc_2++;
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < this._curPage.length)
                {
                    
                    this._boxes[_loc_2].desideIcon();
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function __openCellDiamond(event:BackpackEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = this._boxes.indexOf(event.data);
            if (_loc_2 != -1)
            {
                _loc_3 = (_loc_2 + 1) - (this._bagObj.info.openningGridId - 1);
                _loc_4 = this.getCost((_loc_2 + 1));
                Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11923"), [_loc_4, _loc_3]), LanguageCfgObj.getInstance().getByIndex("11924"), [(_loc_2 + 1), _loc_4], this.yesToOpenCell);
            }
            return;
        }// end function

        private function getCost(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_4:* = null;
            var _loc_3:* = this._bagObj.info.openningGridId;
            while (_loc_3 <= param1)
            {
                
                _loc_4 = BackpackOpenCfgObj.getInstance().getCost("1_" + _loc_3);
                if (_loc_4)
                {
                    _loc_2 = _loc_2 + int(_loc_4.q_cost);
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        private function yesToOpenCell(... args) : void
        {
            if (UserObj.getInstance().playerInfo.gold >= args[1])
            {
                if (ProtectControl.getInstance().promptIfLocked())
                {
                    return;
                }
                this._backpackControl.openCell(args[0]);
            }
            else
            {
                MapControl.getInstance().showRechargeD();
            }
            return;
        }// end function

        private function __openCell(event:BackpackEvent) : void
        {
            var _loc_2:* = this._boxes.indexOf(event.data);
            if (_loc_2 != -1)
            {
                this._backpackControl.openCell((_loc_2 + 1));
            }
            return;
        }// end function

        private function __itemDragFalse(event:DragEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this.getBounds(FrameworkGlobal.stage);
            if (!_loc_2.contains(event.data.point.x, event.data.point.y))
            {
                _loc_3 = event.data.info as PropInfo;
                Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11925"), [_loc_3.q_name]), "", [_loc_3], this.yesToDrop);
            }
            return;
        }// end function

        private function __itemTranscation(event:BackpackEvent) : void
        {
            BackPackControl.getInstance().moveToTranscation(event.data.info);
            return;
        }// end function

        private function __addToStalls(event:BackpackEvent) : void
        {
            BackPackControl.getInstance().addToStalls(event.data.info);
            return;
        }// end function

        private function __itemSell(event:BackpackEvent) : void
        {
            BackPackControl.getInstance().soldItem(event.data);
            return;
        }// end function

        private function __itemMove(event:BackpackEvent) : void
        {
            this._dragItem = event.data.item;
            this._targetItem = event.data.targetItem;
            this._backpackControl.moveItem(event.data.itemId, event.data.toGridId, event.data.num);
            return;
        }// end function

        public function changeToSell() : void
        {
            this.initBorder(16763904);
            return;
        }// end function

        public function initBorder(param1:uint) : void
        {
            if (this._sellBorder == null)
            {
                this._sellBorder = new Sprite();
                this._sellBorder.mouseChildren = false;
                this._sellBorder.mouseEnabled = false;
                this._sellBorder.x = this._bg.x - 1;
                this._sellBorder.y = this._bg.y - 1;
            }
            this._sellBorder.graphics.clear();
            this._sellBorder.graphics.lineStyle(2, param1);
            this._sellBorder.graphics.drawRoundRect(0, 0, this._bg.width + 2, this._bg.height + 2, 2, 2);
            this._sellBorder.graphics.endFill();
            addChild(this._sellBorder);
            this._sellBorder.alpha = 0.3;
            this.startTween();
            addEvtListener(MouseEvent.CLICK, this.__itemClick);
            return;
        }// end function

        public function showOpenItemrenderer() : void
        {
            var _loc_1:* = this.getNextUnOpenItem();
            if (_loc_1 != null)
            {
                ButtonFlicker2Control.getInstance().addButtonFlicker(_loc_1);
                this._shrinkItem = _loc_1;
                this._openFlicker = setTimeout(this.cancelFlicker, 8000, _loc_1);
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10356"));
            }
            return;
        }// end function

        private function cancelFlicker(param1:Itemrenderer = null) : void
        {
            if (param1 == null)
            {
                param1 = this._shrinkItem;
            }
            BackPackControl.getInstance().isShowingOpenItemrender = false;
            if (param1 == null)
            {
                return;
            }
            ButtonFlicker2Control.getInstance().removeButtonFlicker(param1);
            this._shrinkItem = null;
            return;
        }// end function

        private function getNextUnOpenItem() : Itemrenderer
        {
            var _loc_1:* = this._boxes.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (this._boxes[_loc_2].status != Params.CELL_NORMAL)
                {
                    return this._boxes[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        private function __itemClick(event:MouseEvent) : void
        {
            if (BackPackControl.getInstance().isSell())
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10357"));
            }
            else if (BackPackControl.getInstance().isTranscation())
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10358"));
            }
            else if (BackPackControl.getInstance().isAddToStalls())
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10359"));
            }
            event.stopImmediatePropagation();
            return;
        }// end function

        public function setLock(param1:long, param2:Boolean) : void
        {
            var _loc_3:* = this.getItemrenderById(param1);
            _loc_3.setLocked(param2);
            return;
        }// end function

        public function dealCellStatus(param1:int) : void
        {
            var _loc_2:* = 0;
            if (param1 == 0)
            {
                param1 = BackpackObj.CAPACITY;
            }
            _loc_2 = BackpackObj.getInstance().info.cellNum;
            while (_loc_2 < param1)
            {
                
                this._boxes[_loc_2].status = Params.CELL_OPENED;
                this._boxes[_loc_2].repaintExpTips();
                _loc_2++;
            }
            _loc_2 = param1;
            while (_loc_2 < this._maxLen)
            {
                
                this._boxes[_loc_2].status = Params.CELL_LOCKED;
                this._boxes[_loc_2].repaintExpTips();
                _loc_2++;
            }
            return;
        }// end function

        public function openCellRes(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = this._bagObj.info.cellNum;
            while (_loc_2 < param1)
            {
                
                this._boxes[_loc_2].status = Params.CELL_NORMAL;
                this._boxes[_loc_2].repaintExpTips();
                _loc_2++;
            }
            if (this._openBox)
            {
                _loc_3 = this._boxes.indexOf(this._openBox);
                if ((_loc_3 + 1) <= param1)
                {
                    if ((param1 + 1) <= BackpackObj.CAPACITY)
                    {
                        this._backpackControl.reqCellTime((param1 + 1));
                    }
                    else
                    {
                        BackpackObj.getInstance().info.openningGridId = 0;
                        BackpackObj.getInstance().info.cellTime = 0;
                    }
                }
            }
            this._bagObj.info.cellNum = param1;
            return;
        }// end function

        public function changeToTranscation() : void
        {
            this.initBorder(16763904);
            this.lockToBind(true);
            this.checkArrageable();
            return;
        }// end function

        public function changeToStalls() : void
        {
            this.initBorder(16763904);
            return;
        }// end function

        public function lockBind() : void
        {
            this.lockToBind(true);
            return;
        }// end function

        public function releaseunInteractive() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._boxes.length)
            {
                
                this._boxes[_loc_1].setLocked(false);
                _loc_1++;
            }
            return;
        }// end function

        private function lockToBind(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            if (this._sort == BackpackObj.TOTAL)
            {
                _loc_2 = 0;
                while (_loc_2 < this._bagObj.info.cellNum)
                {
                    
                    if (this._boxes[_loc_2].info && (this._boxes[_loc_2].info.isbind || this._boxes[_loc_2].info.isHighLocked))
                    {
                        this._boxes[_loc_2].setBind(param1);
                    }
                    _loc_2++;
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < this._boxes.length)
                {
                    
                    if (this._boxes[_loc_2].info && this._boxes[_loc_2].info.isbind)
                    {
                        this._boxes[_loc_2].setBind(param1);
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function openItemChange() : void
        {
            if (this.getMaxLen() > this._maxLen)
            {
                this.addBoxItem();
            }
            if (this._openBox)
            {
                this.dealCellStatus(BackpackObj.getInstance().info.openningGridId);
                this.dealOpenBox(true);
            }
            return;
        }// end function

        public function dealOpenBox(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (BackpackObj.getInstance().info.openningGridId == 0 && BackpackObj.getInstance().info.cellTime == 0)
            {
                return;
            }
            this._boxes[(BackpackObj.getInstance().info.openningGridId - 1)].status = Params.CELL_OPENNING;
            if (param1)
            {
                _loc_2 = "1_" + BackpackObj.getInstance().info.openningGridId;
                _loc_3 = BackpackOpenCfgObj.getInstance().getCost(_loc_2);
                _loc_4 = CDManager.getInstance().getCD(CDTypes.BACKPACK_OPEN);
                this._openBox = this._boxes[(BackpackObj.getInstance().info.openningGridId - 1)];
                this._openBox.info = null;
                this._boxes[(BackpackObj.getInstance().info.openningGridId - 1)].setCD(_loc_4[0], _loc_3.q_time * 1000);
            }
            else
            {
                this._boxes[(BackpackObj.getInstance().info.openningGridId - 1)].clearCDMask();
            }
            return;
        }// end function

        private function addBoxItem() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = this._maxLen;
            while (_loc_2 < this._maxLen + ROW)
            {
                
                _loc_1 = new Itemrenderer();
                _loc_1.place = Params.ITEM_PLACE_BACKPACK;
                _loc_1.gridId = _loc_2 + 1;
                _loc_1.accpetKey = [Params.ITEM_PLACE_BACKPACK, Params.ITEM_PLACE_ROLEPANEL, Params.ITEM_PLACE_STORE];
                _loc_1.parentContainer = this;
                this._bagContainer.add(_loc_1, false, 0, 0);
                this._boxes.push(_loc_1);
                _loc_2++;
            }
            this._maxLen = this.getMaxLen();
            _loc_2 = BackpackObj.getInstance().info.openningGridId;
            while (_loc_2 < this._maxLen)
            {
                
                this._boxes[_loc_2].status = Params.CELL_LOCKED;
                this._boxes[_loc_2].info = null;
                _loc_2++;
            }
            this.dealOpenBox(true);
            this._scrollpanel.updateThumb();
            this._scrollpanel.scrollToBottom();
            return;
        }// end function

        private function startTween() : void
        {
            var _loc_1:* = NaN;
            if (Math.abs(this._sellBorder.alpha - 0.3) < 0.01)
            {
                _loc_1 = 1;
            }
            else if (Math.abs((this._sellBorder.alpha - 1)) < 0.01)
            {
                _loc_1 = 0.3;
            }
            TweenLite.to(this._sellBorder, 1, {alpha:_loc_1, onComplete:this.startTween});
            return;
        }// end function

        public function closeSelectStatus() : void
        {
            TweenLite.killTweensOf(this._sellBorder);
            if (this._sellBorder && this._sellBorder.parent)
            {
                this._sellBorder.parent.removeChild(this._sellBorder);
            }
            removeEvtListener(MouseEvent.CLICK, this.__itemClick);
            return;
        }// end function

        private function __itemRemove(event:BackpackEvent) : void
        {
            var _loc_3:* = null;
            this.refreshSelect();
            var _loc_2:* = event.data as PropInfo;
            if (_loc_2 == null)
            {
                return;
            }
            if (this._sort == BackpackObj.TOTAL)
            {
                this._boxes[(_loc_2.gridId - 1)].info = null;
            }
            else
            {
                _loc_3 = this._bagObj.getTabOfItem(_loc_2);
                if (_loc_3 == this._sort)
                {
                    this.updateBoxes();
                }
            }
            return;
        }// end function

        private function __itemAdd(event:BackpackEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.data as PropInfo;
            if (_loc_2 == null)
            {
                return;
            }
            if (this._sort == BackpackObj.TOTAL)
            {
                this._boxes[(_loc_2.gridId - 1)].info = _loc_2;
            }
            else
            {
                _loc_3 = this._bagObj.getTabOfItem(_loc_2);
                if (_loc_3 == this._sort)
                {
                    this.updateBoxes();
                }
            }
            return;
        }// end function

        private function __updateGold(event:RoleEvent = null) : void
        {
            this._diamondTxt.text = ToolKit.getMoneyString(UserObj.getInstance().playerInfo.gold);
            return;
        }// end function

        private function __updateBindedDiamond(event:RoleEvent = null) : void
        {
            this._bindedDiamondTxt.text = ToolKit.getMoneyString(UserObj.getInstance().playerInfo.bindgold);
            return;
        }// end function

        private function __updateMoney(event:RoleEvent = null) : void
        {
            this._goldTxt.text = ToolKit.getMoneyString(UserObj.getInstance().playerInfo.money);
            return;
        }// end function

        public function set dragItemNum(param1:int) : void
        {
            this._dragItemNum = param1;
            return;
        }// end function

        private function __boxChange(event:BackpackEvent) : void
        {
            if (!event.data)
            {
                return;
            }
            if (!event.data.info)
            {
                return;
            }
            if (this._targetItem)
            {
                if (event.data.info.gridId == this._targetItem.gridId)
                {
                    if (this._dragItem)
                    {
                        this._dragItem.info = null;
                    }
                    this._dragItem = null;
                }
            }
            if (this._dragItem)
            {
                if (event.data.info.gridId == this._dragItem.gridId)
                {
                    if (this._targetItem)
                    {
                        this._targetItem.info = null;
                    }
                    this._targetItem = null;
                }
            }
            var _loc_2:* = this.getItemrenderByGrId((event.data.info as PropInfo).gridId);
            if (_loc_2 != null)
            {
                _loc_2.setInfo(event.data.info);
            }
            return;
        }// end function

        private function getItemrenderById(param1:long) : Itemrenderer
        {
            var _loc_2:* = this._boxes.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._boxes[_loc_3].info && this._boxes[_loc_3].info.itemId.equal(param1))
                {
                    return this._boxes[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        private function getItemrenderByInfo(param1:PropInfo) : Itemrenderer
        {
            if (param1 == null)
            {
                Log.error(" in backpackView");
            }
            var _loc_2:* = this._boxes.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._boxes[_loc_3].info && this._boxes[_loc_3].info.itemId.equal(param1.itemId))
                {
                    return this._boxes[_loc_3];
                }
                _loc_3++;
            }
            return null;
        }// end function

        public function update() : void
        {
            this._goldTxt.text = ToolKit.getMoneyString(UserObj.getInstance().playerInfo.money);
            this._bindedDiamondTxt.text = ToolKit.getMoneyString(UserObj.getInstance().playerInfo.bindgold);
            this._diamondTxt.text = ToolKit.getMoneyString(UserObj.getInstance().playerInfo.gold);
            this.checkArrageable();
            return;
        }// end function

        private function checkArrageable() : void
        {
            if (BackPackControl.getInstance().mode == BackPackControl.TRANSCATION || this._arrangeTimer && this._arrangeTimer.running)
            {
                this._arrageBtn.enabled = false;
            }
            else
            {
                this._arrageBtn.enabled = true;
            }
            if (BackPackControl.getInstance().mode == BackPackControl.ADDTOSTALLS)
            {
                this.lockBind();
            }
            return;
        }// end function

        private function __modeChange(event:BackpackEvent) : void
        {
            switch(BackPackControl.getInstance().mode)
            {
                case BackPackControl.NORMAL:
                {
                    this.closeSelectStatus();
                    this.updateSell();
                    this._sellBtn.enabled = true;
                    break;
                }
                case BackPackControl.SELL:
                {
                    this.updateSell();
                    break;
                }
                case BackPackControl.ADDTOSTALLS:
                {
                    this.changeToStalls();
                    this._sellBtn.enabled = false;
                    break;
                }
                case BackPackControl.TRANSCATION:
                {
                    this.changeToTranscation();
                    this._sellBtn.enabled = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (BackPackControl.getInstance().mode != BackPackControl.NORMAL)
            {
                FrameworkGlobal.stage.addEventListener("rightClick", this.__rightClick);
            }
            return;
        }// end function

        private function __rightClick(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener("rightClick", this.__stageRightClick);
            BackPackControl.getInstance().cancelFastClick();
            return;
        }// end function

        public function updateSell() : void
        {
            if (BackPackControl.getInstance().mode == BackPackControl.SELL)
            {
                this._sellBtn.setText(LanguageCfgObj.getInstance().getByIndex("10360"));
            }
            else if (BackPackControl.getInstance().mode == BackPackControl.NORMAL)
            {
                this._sellBtn.setText(LanguageCfgObj.getInstance().getByIndex("10353"));
            }
            if (BackPackControl.getInstance().mode == BackPackControl.SELL || BackPackControl.getInstance().mode == BackPackControl.NORMAL)
            {
                this._sellBtn.enabled = true;
            }
            else
            {
                this._sellBtn.enabled = false;
            }
            return;
        }// end function

        public function close() : void
        {
            BackpackObj.getInstance().removeEvtListener(BackpackEvent.MODE_CHANGE, this.__modeChange);
            this.refreshSelect();
            this.cancelArrang();
            this._backpackControl.returnOtherToNormal();
            this.closeSelectStatus();
            this.dealOpenBox(false);
            return;
        }// end function

        private function refreshSelect() : void
        {
            if (this._selectedItem)
            {
                this._selectedItem.selected = false;
                this._selectedItem = null;
            }
            return;
        }// end function

        private function yesToDrop(param1:PropInfo) : void
        {
            this._backpackControl.delItem(param1);
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._arrageBtn:
                {
                    this._backpackControl.arrange();
                    break;
                }
                case this._rechargeBtn:
                {
                    MapControl.getInstance().showRecharge();
                    break;
                }
                case this._shopBtn:
                {
                    ShopController.getInstance().openShop();
                    break;
                }
                case this._depotBtn:
                {
                    this._backpackControl.openDepot();
                    break;
                }
                case this._oneKeyBtn:
                {
                    ShopController.getInstance().openOneKey();
                    break;
                }
                case this._sellBtn:
                {
                    if (BackPackControl.getInstance().mode == BackPackControl.NORMAL)
                    {
                        BackPackControl.getInstance().mode = BackPackControl.SELL;
                        this.changeToSell();
                    }
                    else if (BackPackControl.getInstance().mode == BackPackControl.SELL)
                    {
                        if (BackPackControl.getInstance().mode == BackPackControl.SELL)
                        {
                            BackPackControl.getInstance().mode = BackPackControl.NORMAL;
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            event.stopImmediatePropagation();
            return;
        }// end function

        private function __stageRightClick(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener("rightClick", this.__stageRightClick);
            ShopController.getInstance().cancelSell();
            return;
        }// end function

        private function __boxSelected(event:BackpackEvent) : void
        {
            if (this._selectedItem)
            {
                this._selectedItem.selected = false;
            }
            this._selectedItem = event.data;
            this._selectedItem.selected = true;
            return;
        }// end function

        private function onTabChange(event:Event) : void
        {
            switch(event.target.selectBtn)
            {
                case this._totalTab:
                {
                    this._sort = BackpackObj.TOTAL;
                    break;
                }
                case this._equipTab:
                {
                    this._sort = BackpackObj.EQUIP;
                    break;
                }
                case this._diamondTab:
                {
                    this._sort = BackpackObj.DIAMOND;
                    break;
                }
                case this._medicinalTab:
                {
                    this._sort = BackpackObj.MEDICINAL;
                    break;
                }
                case this._otherTab:
                {
                    this._sort = BackpackObj.OTHER;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.refreshSelect();
            this.updateBoxes(this._sort);
            return;
        }// end function

        public function checkArrang() : void
        {
            if (this._sort == BackpackObj.TOTAL)
            {
                this.cancelArrang();
                if (BackpackObj.getInstance().checkNeedArrang())
                {
                    ButtonFlicker2Control.getInstance().addButtonFlicker(this._arrageBtn);
                    TweenLite.delayedCall(5, this.cancelArrang);
                }
            }
            return;
        }// end function

        public function open() : void
        {
            this.updateSell();
            this.dealCellStatus(BackpackObj.getInstance().info.openningGridId);
            this.dealOpenBox(true);
            this.updateBoxes();
            this.update();
            this.checkArrang();
            BackpackObj.getInstance().addEvtListener(BackpackEvent.MODE_CHANGE, this.__modeChange);
            ArtifactControl.getInstance().openAutoExtractMsgPanelIfNeeded();
            return;
        }// end function

        private function cancelArrang() : void
        {
            ButtonFlicker2Control.getInstance().removeButtonFlicker(this._arrageBtn);
            return;
        }// end function

        public function updateBoxes(param1:String = "", param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_3 = param1;
            if (_loc_3 == "")
            {
                _loc_3 = this._sort;
            }
            if (_loc_3 == "")
            {
                _loc_3 = BackpackObj.TOTAL;
            }
            this._sort = _loc_3;
            this._curPage = BackpackObj.getInstance().getGoodsByTab(_loc_3);
            var _loc_4:* = this._curPage.length;
            this._bagContainer.reset();
            if (_loc_3 == BackpackObj.TOTAL)
            {
                this.dealOpenBox(true);
                _loc_5 = 0;
                while (_loc_5 < this._maxLen)
                {
                    
                    this._boxes[_loc_5].isEmpty = true;
                    _loc_5++;
                }
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    if (this._curPage[_loc_5].gridId > -1)
                    {
                        if (this._curPage[_loc_5].gridId > this._boxes.length)
                        {
                            Log.log("gridId 大于格子数 gridId" + this._curPage[_loc_5].gridId + " 物品id" + this._curPage[_loc_5].itemId + " 模板 " + this._curPage[_loc_5].itemModelId);
                        }
                        else
                        {
                            _loc_6 = this._boxes[(this._curPage[_loc_5].gridId - 1)];
                            _loc_6.isEmpty = false;
                            _loc_6.setInfo(this._curPage[_loc_5], param2);
                        }
                    }
                    else
                    {
                        Log.log("gridId 小于 0" + this._curPage[_loc_5].gridId + " 物品id" + this._curPage[_loc_5].itemId + " 模板 " + this._curPage[_loc_5].itemModelId);
                    }
                    _loc_5++;
                }
                _loc_5 = 0;
                while (_loc_5 < this._maxLen)
                {
                    
                    if (this._boxes[_loc_5].isEmpty)
                    {
                        this._boxes[_loc_5].setInfo(null);
                    }
                    this._bagContainer.add(this._boxes[_loc_5]);
                    _loc_5++;
                }
            }
            else
            {
                this.dealOpenBox(false);
                _loc_7 = [];
                this._bagContainer.resize();
                _loc_5 = 0;
                while (_loc_5 < this._maxLen)
                {
                    
                    if (_loc_5 < this._curPage.length)
                    {
                        _loc_6 = this.getBox(this._curPage[_loc_5]);
                        if (_loc_6 == null)
                        {
                            _loc_6 = this.getItemrenderByGrId(this._curPage[_loc_5].gridId);
                            _loc_6.setInfo(this._curPage[_loc_5]);
                        }
                        if (!_loc_6.parent)
                        {
                            this._bagContainer.add(_loc_6);
                        }
                    }
                    _loc_5++;
                }
            }
            this._scrollpanel.updateThumb();
            return;
        }// end function

        public function getBox(param1:PropInfo) : Itemrenderer
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._boxes.length)
            {
                
                if (this._boxes[_loc_2].info && this._boxes[_loc_2].info == param1)
                {
                    return this._boxes[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function clearUp() : void
        {
            this.arrangeCountDown();
            this.cancelArrang();
            this.updateBoxes("", true);
            return;
        }// end function

        public function arrangeCountDown() : void
        {
            if (!this._arrangeTimer)
            {
                this._arrangeTimer = new Timer(1000, ARRANGECOUNT);
            }
            this._arrangeTimer.addEventListener(TimerEvent.TIMER, this.__arrangeTime);
            this._arrangeTimer.reset();
            this._arrageBtn.enabled = false;
            this.__arrangeTime();
            this._arrangeTimer.start();
            return;
        }// end function

        private function __arrangeTime(event:TimerEvent = null) : void
        {
            var _loc_2:* = 0;
            if (event == null)
            {
                _loc_2 = ARRANGECOUNT;
            }
            else
            {
                _loc_2 = ARRANGECOUNT - this._arrangeTimer.currentCount;
            }
            if (this._arrangeTimer.currentCount != ARRANGECOUNT)
            {
                this._arrageBtn.setText(_loc_2 + LanguageCfgObj.getInstance().getByIndex("10009"));
            }
            else
            {
                this._arrangeTimer.removeEventListener(TimerEvent.TIMER, this.__arrangeTime);
                this._arrageBtn.enabled = true;
                this._arrageBtn.setText(LanguageCfgObj.getInstance().getByIndex("10352"));
            }
            return;
        }// end function

        private function getItemrenderByGrId(param1:int) : Itemrenderer
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._boxes.length)
            {
                
                if (this._boxes[_loc_2].gridId == param1)
                {
                    return this._boxes[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function checkModelInfo(param1:PropInfo, param2:int) : Boolean
        {
            if (param1.itemModelId != param2)
            {
                return false;
            }
            if (param1.num >= param1.q_max)
            {
                return false;
            }
            return true;
        }// end function

        public function releaseLock() : void
        {
            this.lockToBind(false);
            this.releaseunInteractive();
            this.checkArrageable();
            return;
        }// end function

        public function repaintExp() : void
        {
            this.dealCellStatus(BackpackObj.getInstance().info.openningGridId);
            this.dealOpenBox(true);
            return;
        }// end function

        override public function finalize() : void
        {
            this._arrageBtn.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._depotBtn.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._shopBtn.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._oneKeyBtn.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._curPage = null;
            super.finalize();
            return;
        }// end function

    }
}
