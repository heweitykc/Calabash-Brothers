package com.game.casting.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.game.casting.bean.*;
    import com.game.casting.message.*;
    import com.game.casting.protocol.*;
    import com.game.casting.view.*;
    import com.game.guide.consts.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.prey.control.*;
    import com.greensock.*;
    import com.model.*;

    public class ZhuZaoControl extends Object
    {
        private var _zhuZaoPanel:ZhuZaoPanel;
        private var _zhuZaoProtocol:ZhuZaoProtocol;
        private var _technologyPoint:int;
        private var _gridInfos:Array;
        private var isOneKeyCasting:Boolean = false;
        private var canOp:Boolean = true;
        public static const MAX_GRID_NUM:int = 9;
        private static var instance:ZhuZaoControl;

        public function ZhuZaoControl()
        {
            this._gridInfos = new Array(MAX_GRID_NUM);
            this._zhuZaoProtocol = new ZhuZaoProtocol();
            return;
        }// end function

        public function openZhuZaoPanel() : void
        {
            if (!GuideConfigObj.getInstance().isOpenFunction(GuideConfigObj.getInstance().ZHU_ZAO_ACTIVE_TEAM))
            {
                return;
            }
            if (!this._zhuZaoPanel)
            {
                this._zhuZaoPanel = new ZhuZaoPanel();
                Global.popManager.addPop(this._zhuZaoPanel);
            }
            this._zhuZaoPanel.openOrClose();
            return;
        }// end function

        public function reqCastingOpenToServer() : void
        {
            this._zhuZaoProtocol.reqCastingOpenToServer();
            return;
        }// end function

        public function reqCastingRewardOneKeyToServer() : void
        {
            var _loc_1:* = GlobalCfgObj.getInstance().getCostOnekeyCasting();
            this.isOneKeyCasting = true;
            this.reqCastingReward();
            return;
        }// end function

        public function reqCastingRewardToServer() : void
        {
            this.isOneKeyCasting = false;
            this.reqCastingReward();
            return;
        }// end function

        private function reqCastingReward() : void
        {
            var cost:* = QCastingCostCfgObj.getInstance().getCostByLevel(UserObj.getInstance().playerInfo.level);
            if (UserObj.getInstance().chechMoneyEnough(cost) && this.hasEmptyPlace() && this._zhuZaoPanel && this._zhuZaoPanel && this._zhuZaoPanel.isOpen)
            {
                Ticker.registerTimer(0.1, function () : void
            {
                _zhuZaoProtocol.reqCastingRewardToServer();
                return;
            }// end function
            , null, 1);
            }
            else if (!UserObj.getInstance().chechMoneyEnough(cost))
            {
                FunGuideControl.getInstance().showRemind(FunGuideConst.GOLD);
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10429"));
            }
            return;
        }// end function

        public function showPrayPanel() : void
        {
            PrayControl.getInstance().openOrClosePrayBox();
            return;
        }// end function

        public function reqCastingUseItemToServer(param1:int, param2:int) : void
        {
            var gridId:* = param1;
            var type:* = param2;
            if (this.canOp)
            {
                this.canOp = false;
                this._zhuZaoProtocol.reqCastingUseItemToServer(gridId, type);
                TweenLite.delayedCall(0.3, function () : void
            {
                canOp = true;
                return;
            }// end function
            );
            }
            return;
        }// end function

        public function reqCastingDecomposeToServer() : void
        {
            this._zhuZaoProtocol.reqCastingDecomposeToServer();
            return;
        }// end function

        public function reqCastingSellToServer() : void
        {
            this._zhuZaoProtocol.reqCastingSellToServer();
            return;
        }// end function

        public function reqCastingExchangeToServer(param1:int) : void
        {
            this._zhuZaoProtocol.reqCastingExchangeToServer(param1);
            return;
        }// end function

        public function showZhuZhao(param1:CastingGridInfo) : void
        {
            if (this._zhuZaoPanel && this._zhuZaoPanel.isOpen)
            {
                this._zhuZaoPanel.showFlashZhuZhao(param1);
            }
            if (this.isOneKeyCasting)
            {
                this.reqCastingReward();
            }
            return;
        }// end function

        public function useItem(param1:ResCastingUseItemToClientMessage) : void
        {
            if (param1.isSuccess == 0)
            {
                return;
            }
            var _loc_2:* = new Vector.<int>;
            var _loc_3:* = new Vector.<int>;
            this._gridInfos[(param1.grididx - 1)] = null;
            if (param1.type == 1)
            {
                if (this._zhuZaoPanel && this._zhuZaoPanel.isOpen)
                {
                    this._zhuZaoPanel.getToBack(param1.grididx);
                }
            }
            else if (param1.type == 2)
            {
                if (this._zhuZaoPanel && this._zhuZaoPanel.isOpen)
                {
                    _loc_2.push(param1.grididx);
                    _loc_3.push(param1.value);
                    this._zhuZaoPanel.showSellFlash(_loc_2, _loc_3);
                }
            }
            else if (param1.type == 3)
            {
                if (this._zhuZaoPanel && this._zhuZaoPanel.isOpen)
                {
                    _loc_2.push(param1.grididx);
                    _loc_3.push(param1.value);
                    this._zhuZaoPanel.showDecomposeFlash(_loc_2, _loc_3);
                }
            }
            this.reqCastingOpenToServer();
            return;
        }// end function

        private function hasEmptyPlace() : Boolean
        {
            var _loc_1:* = 0;
            while (_loc_1 < MAX_GRID_NUM)
            {
                
                if (!this._gridInfos[_loc_1] || this._gridInfos[_loc_1].iteminfo)
                {
                    return true;
                }
                _loc_1++;
            }
            return false;
        }// end function

        public function showDecomposeFlash(param1:Vector.<int>, param2:Vector.<int>) : void
        {
            if (this._zhuZaoPanel && this._zhuZaoPanel.isOpen)
            {
                this._zhuZaoPanel.showDecomposeFlash(param1, param2);
            }
            this._zhuZaoProtocol.reqCastingOpenToServer();
            return;
        }// end function

        public function showSellFlash(param1:Vector.<int>, param2:Vector.<int>) : void
        {
            if (this._zhuZaoPanel && this._zhuZaoPanel.isOpen)
            {
                this._zhuZaoPanel.showSellFlash(param1, param2);
            }
            this._zhuZaoProtocol.reqCastingOpenToServer();
            return;
        }// end function

        public function get technologyPoint() : int
        {
            return this._technologyPoint;
        }// end function

        public function set technologyPoint(param1:int) : void
        {
            if (this._zhuZaoPanel)
            {
                this._zhuZaoPanel.updateGongYi(param1);
            }
            this._technologyPoint = param1;
            return;
        }// end function

        public function get gridInfos() : Array
        {
            return this._gridInfos;
        }// end function

        public function set gridInfos(param1:Array) : void
        {
            this._gridInfos = param1;
            if (this._zhuZaoPanel && this._zhuZaoPanel.isOpen)
            {
                this._zhuZaoPanel.freshInfo();
            }
            return;
        }// end function

        public static function getInstance() : ZhuZaoControl
        {
            if (instance == null)
            {
                instance = new ZhuZaoControl;
            }
            return instance;
        }// end function

    }
}
