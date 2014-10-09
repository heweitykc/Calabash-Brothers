package com.game.casting.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.backpack.view.*;
    import com.game.casting.bean.*;
    import com.game.casting.control.*;
    import com.game.casting.view.component.*;
    import com.game.clickstream.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.player.events.*;
    import com.game.player.model.*;
    import com.game.prompt.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ZhuZaoPanel extends BaseBox implements IGuide
    {
        private var _showItemsView:ItemsShowView;
        private var _duihuanBtn:BaseButton;
        private var _pickBtn:BaseButton;
        private var _onekeysellBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _zhuZaoBtn:BaseButton;
        private var _cellContainer:HBox;
        private var _levelslide:MovieClip;
        private var _level0:BaseButton;
        private var _level1:BaseButton;
        private var _level2:BaseButton;
        private var _level3:BaseButton;
        private var _level4:BaseButton;
        private var _pick:Boolean;
        private var _effect:BaseSprite;
        private var canop:int = 0;
        private var flashPoint:Point;
        private var _nodeArray:Array;
        private var isWarn:Boolean = true;
        private var _position:int = 1;

        public function ZhuZaoPanel()
        {
            _peaceBox = ["com.game.casting.view::ZhuZaoExchangePanel", "com.game.prey.view.PrayBox"];
            loadDisplay("res/zhuzao.swf");
            this._nodeArray = QCastingShowCfgObj.getInstance().getNodes();
            EquipsObj.getInstance().addEvtListener(EquipEvent.WEAR, this.__updateEquips);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("zhuzao_panel");
            this.initUI();
            super.displayReady();
            this.registerGuide();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            this._showItemsView = new ItemsShowView();
            this._showItemsView.move(200, 105);
            addChild(this._showItemsView);
            this._levelslide = getDisplayChildByName("levelslide");
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._pickBtn = new BaseButton(getDisplayChildByName("pickBtn"));
            this._onekeysellBtn = new BaseButton(getDisplayChildByName("onekeysellBtn"));
            this._zhuZaoBtn = new BaseButton(getDisplayChildByName("zhuZaoBtn"));
            var _loc_1:* = this._nodeArray.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1)
            {
                
                _loc_2 = this["_level" + _loc_3];
                _loc_2 = new BaseButton(getDisplayChildByName("level" + _loc_3));
                _loc_2.setText(this._nodeArray[_loc_3].level);
                StringTip.create(_loc_2, this._nodeArray[_loc_3].tips);
                _loc_3++;
            }
            StringTip.create(this._onekeysellBtn, LanguageCfgObj.getInstance().getByIndex("10430"), true);
            this._cellContainer = new HBox();
            this._cellContainer.oneRow = 3;
            this._cellContainer.intervalX = 1;
            this._cellContainer.intervalY = 1;
            this._cellContainer.move(570, 108);
            addChild(this._cellContainer);
            addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
            addEvtListener(MouseEvent.CLICK, this.__click);
            _loc_1 = ZhuZaoControl.MAX_GRID_NUM;
            _loc_3 = 0;
            while (_loc_3 < _loc_1)
            {
                
                _loc_4 = new EquipIconItem();
                this._cellContainer.add(_loc_4);
                _loc_4.addEvtListener(MouseEvent.CLICK, this.__clickItem);
                _loc_4.addEvtListener("rightClick", this.__clickItem);
                _loc_3++;
            }
            this._effect = new BaseSprite();
            this._effect.mouseEnabled = false;
            var _loc_5:* = new VMCView();
            _loc_5.loadRes("res/image/zhuzao/over_middle.png", null, true);
            _loc_5.auto = true;
            _loc_5.updatePose("90", true);
            this._effect.addChild(_loc_5);
            _loc_5 = new VMCView();
            _loc_5.auto = true;
            _loc_5.loadRes("/res/image/zhuzao/over_front.png", null, true);
            _loc_5.updatePose("90", true);
            this._effect.move(47, 47);
            this._effect.addChild(_loc_5);
            this._zhuZaoBtn.addEvtListener(MouseEvent.MOUSE_OUT, this.__out);
            this.freshInfo();
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            if (this._effect && this._effect.parent)
            {
                this._effect.parent.removeChild(this._effect);
            }
            return;
        }// end function

        public function freshInfo() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (UILoaded && isOpen)
            {
                StringTip.create(this._zhuZaoBtn, "<font color=\'#fff600\'>" + LanguageCfgObj.getInstance().getByIndex("11946") + "</font><br/>" + "<font color=\'#ffffff\'>" + "<font color=\'#ffffff\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11947"), [ToolKit.getMoneyString(QCastingCostCfgObj.getInstance().getCostByLevel(UserObj.getInstance().playerInfo.level))]) + "</font>", true);
                _loc_1 = ZhuZaoControl.getInstance().gridInfos;
                _loc_2 = ZhuZaoControl.MAX_GRID_NUM;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    (this._cellContainer.getContent(_loc_3) as EquipIconItem).setEquipInfo(_loc_1[_loc_3]);
                    _loc_3++;
                }
            }
            return;
        }// end function

        public function showFlashZhuZhao(param1:CastingGridInfo) : void
        {
            var currentItem:EquipIconItem;
            var item:* = param1;
            currentItem = this._cellContainer.getContent(item.grididx) as EquipIconItem;
            var showItem:* = function () : void
            {
                currentItem.setEquipInfo(item);
                var _loc_2:* = canop - 1;
                canop = _loc_2;
                return;
            }// end function
            ;
            if (currentItem)
            {
                var _loc_3:* = this;
                var _loc_4:* = this.canop + 1;
                _loc_3.canop = _loc_4;
                ItemGetAnim.doFlyGetItemsTo([item.iteminfo.itemModelId], currentItem.localToGlobal(new Point(0, 0)), this.flashPoint);
            }
            Ticker.registerTimer(1, showItem, null, 1);
            return;
        }// end function

        public function showDecomposeFlash(param1:Vector.<int>, param2:Vector.<int>) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = param1;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = this._cellContainer.getContent(_loc_3[_loc_4]) as EquipIconItem;
                _loc_5.setEquipInfo(null);
                _loc_5.showflash(1, param2[_loc_4]);
                _loc_4++;
            }
            return;
        }// end function

        private function __updateEquips(event:EquipEvent) : void
        {
            ZhuZaoControl.getInstance().reqCastingOpenToServer();
            return;
        }// end function

        public function showSellFlash(param1:Vector.<int>, param2:Vector.<int>) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = param1;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = this._cellContainer.getContent(_loc_3[_loc_4]) as EquipIconItem;
                _loc_5.setEquipInfo(null);
                _loc_5.showflash(2, param2[_loc_4]);
                _loc_4++;
            }
            return;
        }// end function

        public function getToBack(param1:int) : void
        {
            var _loc_2:* = this._cellContainer.getContent(param1) as EquipIconItem;
            var _loc_3:* = _loc_2.obj.iteminfo.itemModelId;
            ItemGetAnim.doFlyToBackPack(_loc_3, _loc_2.localToGlobal(new Point(0, 0)));
            _loc_2.setEquipInfo(null);
            return;
        }// end function

        public function updateGongYi(param1:int) : void
        {
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._closeBtn:
                {
                    this.close();
                    break;
                }
                case this._pickBtn:
                {
                    this._pick = !this._pick;
                    if (this._pick)
                    {
                        Global.primaryCursorManager.showGetIcon();
                    }
                    else
                    {
                        Global.primaryCursorManager.hide();
                    }
                    break;
                }
                case this._zhuZaoBtn:
                {
                    ClickStream.add(ClickStreamId.CLICK_DiJingZhuZao_ZhuZao);
                    this.flashPoint = this._zhuZaoBtn.localToGlobal(new Point(5, 5));
                    ZhuZaoControl.getInstance().reqCastingRewardToServer();
                    this.notPick();
                    break;
                }
                case this._onekeysellBtn:
                {
                    if (this.canop <= 0)
                    {
                        ZhuZaoControl.getInstance().reqCastingSellToServer();
                    }
                    this.notPick();
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

        private function setting(param1:Boolean) : void
        {
            this.isWarn = !param1;
            return;
        }// end function

        private function notPick() : void
        {
            this._pick = false;
            Global.primaryCursorManager.hide();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.registerGuide();
            return;
        }// end function

        override public function close() : void
        {
            this.notPick();
            super.close();
            this.guidePause(GuideConfigObj.getInstance().ZHU_ZAO_ACTIVE_TEAM_2);
            return;
        }// end function

        private function __clickItem(event:MouseEvent) : void
        {
            if (this.canop > 0)
            {
                return;
            }
            var _loc_2:* = EquipIconItem(event.currentTarget);
            var _loc_3:* = this._cellContainer.getContentIdx(_loc_2);
            if (this._pick)
            {
                ZhuZaoControl.getInstance().reqCastingUseItemToServer(_loc_3, 1);
            }
            else
            {
                if (event.type == "rightClick")
                {
                    _loc_2.pack();
                    return;
                }
                if (_loc_2 && _loc_2.info)
                {
                    ItemPopMenu.instance.show(_loc_2.info, FrameworkGlobal.stage, 0, 0, ItemPopMenu.ZHUZAO1, null, _loc_3);
                }
                FrameworkGlobal.addMsgListen(ItemPopMenuEvent.SELECT_MENU, this.__selectItem);
            }
            return;
        }// end function

        private function getType(param1:PropInfo) : int
        {
            if (!param1)
            {
                return 0;
            }
            if (param1.q_type == 26)
            {
                return 3;
            }
            if (param1.addAttributLevel >= 1 && param1.intensify >= 7)
            {
                return 1;
            }
            return 2;
        }// end function

        private function __selectItem(event:ItemPopMenuEvent) : void
        {
            var _loc_2:* = ItemPopMenu.instance.obj;
            if (event.itemDate == ItemPopMenu.ZHUZAO_SELL)
            {
                ZhuZaoControl.getInstance().reqCastingUseItemToServer(_loc_2, 2);
            }
            else if (event.itemDate == ItemPopMenu.ZHUZAO_PICK)
            {
                ZhuZaoControl.getInstance().reqCastingUseItemToServer(_loc_2, 1);
            }
            else if (event.itemDate == ItemPopMenu.ZHUZAO_DECOMPOSE)
            {
                ZhuZaoControl.getInstance().reqCastingUseItemToServer(_loc_2, 3);
            }
            return;
        }// end function

        private function addedToStage(event:Event) : void
        {
            this._showItemsView.showItems();
            ZhuZaoControl.getInstance().reqCastingOpenToServer();
            this._levelslide.addEventListener(Event.ENTER_FRAME, this.__play);
            this._levelslide.gotoAndPlay(1);
            this._position = this.getLevelFrame2(UserObj.getInstance().playerInfo.level);
            return;
        }// end function

        private function __play(event:Event) : void
        {
            if (this._levelslide.currentFrame >= this._position)
            {
                this._levelslide.removeEventListener(Event.ENTER_FRAME, this.__play);
                this._levelslide.stop();
            }
            return;
        }// end function

        private function getLevelFrame(param1:int) : int
        {
            var _loc_2:* = 200;
            var _loc_3:* = 160;
            var _loc_4:* = 50;
            var _loc_5:* = 40;
            if (param1 >= _loc_2)
            {
                return _loc_5;
            }
            if (param1 <= _loc_4)
            {
                return 1;
            }
            if (param1 >= _loc_3)
            {
                return Math.floor(_loc_5 / 2 / (_loc_2 - _loc_3) * (param1 - _loc_3) + _loc_5 / 2);
            }
            return Math.floor(_loc_5 / 2 / (_loc_3 - _loc_4) * (param1 - _loc_4));
        }// end function

        private function getLevelFrame2(param1:int) : int
        {
            var _loc_2:* = 40;
            var _loc_3:* = this._nodeArray.length;
            var _loc_4:* = Math.floor(_loc_2 / (_loc_3 - 1));
            if (param1 <= this._nodeArray[0].level)
            {
                return 1;
            }
            if (param1 >= this._nodeArray[(_loc_3 - 1)].level)
            {
                return _loc_2;
            }
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                if (this._nodeArray[_loc_5].level > param1)
                {
                    return Math.ceil(_loc_4 / (this._nodeArray[_loc_5].level - this._nodeArray[(_loc_5 - 1)].level) * (param1 - this._nodeArray[(_loc_5 - 1)].level) + _loc_4 * (_loc_5 - 1));
                }
                _loc_5++;
            }
            return 1;
        }// end function

        override public function finalize() : void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.addedToStage);
            FrameworkGlobal.removeMsgListen(ItemPopMenuEvent.SELECT_MENU, this.__selectItem);
            super.finalize();
            return;
        }// end function

        public function registerGuide() : void
        {
            if (!UILoaded)
            {
                return;
            }
            GuideMultiControl.getInstance().registerGuide(this._zhuZaoBtn, this, GuideConfigObj.getInstance().ZHU_ZAO_ACTIVE_TEAM_2);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            GuideMultiControl.getInstance().backGuide(param1, 1);
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return true;
        }// end function

    }
}
