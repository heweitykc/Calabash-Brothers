package com.game.prey.view
{
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.vmc.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.map.control.*;
    import com.game.pray.bean.*;
    import com.game.prey.control.*;
    import com.game.protect.control.*;
    import com.game.vip.control.*;
    import com.model.*;
    import flash.events.*;
    import flash.text.*;

    public class PrayBox extends BaseBox implements IGuide
    {
        private var btnClose:BaseButton;
        private var canGetExpTxt:PrayBoxTitle;
        private var canGetMoneyTxt:PrayBoxTitle;
        private var getExtBtn:BaseButton;
        private var getMoneyBtn:BaseButton;
        private var goldForExpText:TextField;
        private var remainExpTime:TextField;
        private var goldForMoneyText:TextField;
        private var remainMoneyTime:TextField;
        private var vip:BaseButton;
        private var freePrayBtn:BaseButton;
        private var vipTips:TextField;
        private var allhideView:Array;
        private var _prayInfo:PrayInfo;
        private static var swf:String = "res/pray.swf";

        public function PrayBox(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            loadDisplay(swf);
            _peaceBox = ["com.game.vip.view:VIPPanel"];
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("pray");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function hideforfirstPray() : void
        {
            var _loc_1:* = undefined;
            for each (_loc_1 in this.allhideView)
            {
                
                _loc_1.visible = false;
            }
            this.freePrayBtn.visible = true;
            return;
        }// end function

        private function showforNextPray() : void
        {
            var _loc_1:* = undefined;
            for each (_loc_1 in this.allhideView)
            {
                
                _loc_1.visible = true;
            }
            this.freePrayBtn.visible = false;
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.vip = new BaseButton(getDisplayChildByName("vip"));
            this.vipTips = getDisplayChildByName("vipTips");
            this.getExtBtn = new BaseButton(getDisplayChildByName("getExtBtn"));
            this.getMoneyBtn = new BaseButton(getDisplayChildByName("getMoneyBtn"));
            this.canGetExpTxt = new PrayBoxTitle(PrayBoxTitle.JIN_YAN);
            this.canGetExpTxt.move(396, 79);
            addChild(this.canGetExpTxt);
            this.goldForExpText = getDisplayChildByName("goldForExpText") as TextField;
            this.remainExpTime = getDisplayChildByName("remainExpTime") as TextField;
            this.canGetMoneyTxt = new PrayBoxTitle(PrayBoxTitle.JIN_BI);
            this.canGetMoneyTxt.move(140, 79);
            addChild(this.canGetMoneyTxt);
            this.goldForMoneyText = getDisplayChildByName("goldForMoneyText") as TextField;
            this.remainMoneyTime = getDisplayChildByName("remainMoneyTime") as TextField;
            this.freePrayBtn = new BaseButton(getDisplayChildByName("freePrayBtn"));
            this.allhideView = [];
            this.allhideView.push(getDisplayChildByName("del1"));
            this.allhideView.push(getDisplayChildByName("del2"));
            this.allhideView.push(getDisplayChildByName("del3"));
            this.allhideView.push(getDisplayChildByName("del4"));
            this.allhideView.push(getDisplayChildByName("del5"));
            this.allhideView.push(getDisplayChildByName("del6"));
            this.allhideView.push(this.goldForMoneyText);
            this.allhideView.push(this.remainMoneyTime);
            this.allhideView.push(this.getMoneyBtn);
            this.registerGuide();
            return;
        }// end function

        public function setPrayInfo(param1:PrayInfo) : void
        {
            this._prayInfo = param1;
            if (!this.canGetExpTxt)
            {
                return;
            }
            if (this._prayInfo.firstPray == 0)
            {
                this.hideforfirstPray();
            }
            else
            {
                this.showforNextPray();
            }
            this.canGetExpTxt.value = param1.prayExp.toNumber();
            this.goldForExpText.text = "" + param1.prayExpCost;
            this.remainExpTime.text = "" + param1.prayExpTimes;
            this.canGetMoneyTxt.value = param1.prayGold;
            this.goldForMoneyText.text = "" + param1.prayGoldCost;
            this.remainMoneyTime.text = "" + param1.prayGoldTimes;
            if (param1.prayExpTimes <= 0)
            {
                this.getExtBtn.enabled = false;
            }
            else
            {
                this.getExtBtn.enabled = true;
            }
            if (param1.prayGoldTimes <= 0)
            {
                this.getMoneyBtn.enabled = false;
            }
            else
            {
                this.getMoneyBtn.enabled = true;
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            PrayControl.getInstance().reqPrayInfo();
            if (UserObj.getInstance().playerInfo.vipid >= 9)
            {
                this.vipTips.visible = false;
                this.vip.visible = false;
            }
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this.getExtBtn:
                {
                    if (!this._prayInfo)
                    {
                        return;
                    }
                    if (!UserObj.getInstance().chechGoldEnough(this._prayInfo.prayExpCost))
                    {
                        MapControl.getInstance().showRechargeD();
                        return;
                    }
                    if (ProtectControl.getInstance().promptIfLocked())
                    {
                        return;
                    }
                    PrayControl.getInstance().reqPray(2);
                    break;
                }
                case this.getMoneyBtn:
                {
                    if (!this._prayInfo)
                    {
                        return;
                    }
                    if (!UserObj.getInstance().chechGoldEnough(this._prayInfo.prayGoldCost))
                    {
                        MapControl.getInstance().showRechargeD();
                        return;
                    }
                    if (ProtectControl.getInstance().promptIfLocked())
                    {
                        return;
                    }
                    PrayControl.getInstance().reqPray(1);
                    break;
                }
                case this.vip:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case this.freePrayBtn:
                {
                    this._prayInfo.firstPray = 1;
                    PrayControl.getInstance().reqPray(1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function showResultEffect(param1:int) : void
        {
            var _loc_2:* = new VMCView();
            _loc_2.loadRes("res/image/pray/prayeffect.png");
            _loc_2.updatePose();
            if (param1 == 1)
            {
                _loc_2.move(150, 295);
            }
            else
            {
                _loc_2.move(400, 295);
            }
            _loc_2.addEvtListener(Event.COMPLETE, this.__remove);
            _loc_2.auto = true;
            addChild(_loc_2);
            return;
        }// end function

        private function __remove(event:Event) : void
        {
            var _loc_2:* = event.target as VMCView;
            if (_loc_2 && _loc_2.parent)
            {
                _loc_2.stop();
                removeChild(_loc_2);
            }
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.guidePause(GuideConfigObj.getInstance().PRAY_GUIDE_ID_2);
            this.guidePause(GuideConfigObj.getInstance().PRAY_GUIDE_ID_3);
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this.freePrayBtn, this, GuideConfigObj.getInstance().PRAY_GUIDE_ID_2);
            GuideMultiControl.getInstance().registerGuide(this.btnClose, this, GuideConfigObj.getInstance().PRAY_GUIDE_ID_3);
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
            return UILoaded && isOpen;
        }// end function

    }
}
