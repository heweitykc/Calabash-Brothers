package com.game.batter.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.batter.model.*;
    import com.game.map.model.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;

    public class BatterMonsterKillView extends BaseSprite
    {
        private var back:Sprite;
        private var effBack:Sprite;
        private var vmcSword:VMCView;
        private var vmcWater:VMCView;
        private var vmcFire:VMCView;
        private var vmcRay:VMCView;
        private var vmcswordLight:VMCView;
        private var swordRate:Sprite;
        private var maskShape:Shape;
        private var expRate:MovieClip;
        private var imgKillCount:KillCountImage;
        private var downTime:DownTimer;
        private var _level:int;
        private var _countDownTime:int;
        private var timeLine:TimelineLite;
        private static var BATTER_TIPS_WORD:String = "<font color = \'#FFFFFF\'>" + LanguageCfgObj.getInstance().getByIndex("11936") + "<br>" + "<font color = \'#FFC000\'>" + LanguageCfgObj.getInstance().getByIndex("11937") + "</font><br><br>" + "<font color = \'#FFF2CC\'>" + LanguageCfgObj.getInstance().getByIndex("11938") + "</font>" + "</font>";

        public function BatterMonsterKillView(param1 = null, param2:String = null)
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this.mouseChildren = false;
            this.back = new Sprite();
            this.addChild(this.back);
            this.back.x = 100 + 18;
            this.back.y = -25;
            this.effBack = new Sprite();
            this.vmcFire = new VMCView();
            this.vmcSword = new VMCView();
            this.vmcWater = new VMCView();
            this.vmcRay = new VMCView();
            this.vmcswordLight = new VMCView();
            this.imgKillCount = new KillCountImage();
            this.initMask();
            this.swordRate = ToolKit.getNew("batter_exp_rate");
            this.expRate = ToolKit.getNew("exp_rate_word");
            this.expRate.visible = false;
            this.back.addChild(this.vmcFire);
            this.back.addChild(this.vmcSword);
            this.back.addChild(this.effBack);
            this.effBack.addChild(this.swordRate);
            this.effBack.addChild(this.vmcWater);
            this.back.addChild(this.expRate);
            this.back.addChild(this.vmcswordLight);
            this.back.addChild(this.imgKillCount);
            this.back.addChild(this.vmcRay);
            this.vmcRay.move(25, 25);
            this.vmcswordLight.move(35, 23);
            this.expRate.y = 40;
            this.expRate.x = -26;
            this.effBack.mask = this.maskShape;
            this.imgKillCount.alpha = 0;
            this.downTime = new DownTimer();
            this.downTime.callBack = this.callDownBack;
            StringTip.create(this, BATTER_TIPS_WORD);
            return;
        }// end function

        private function loaderEffect() : void
        {
            this.vmcFire.loadRes("res/effect/batterfire.png", null, true);
            this.vmcFire.auto = true;
            this.vmcFire.updatePose("90", true);
            this.vmcSword.loadRes("res/effect/battereffect.png", null, true);
            this.vmcSword.auto = true;
            this.vmcSword.updatePose("90", true);
            this.vmcWater.loadRes("res/effect/batterwaterlight.png", null, true);
            this.vmcWater.auto = true;
            this.vmcWater.updatePose("90", true);
            return;
        }// end function

        private function initMask() : void
        {
            this.maskShape = new Shape();
            this.maskShape.graphics.beginFill(16776960);
            this.maskShape.graphics.drawRect(0, 0, 120, 20);
            this.maskShape.graphics.endFill();
            this.maskShape.x = -21;
            this.maskShape.y = 15;
            this.back.addChild(this.maskShape);
            return;
        }// end function

        private function callDownBack(param1:int) : void
        {
            if (MapObj.getInstance().mapID == Params.COUNTRY_MAP_ID)
            {
                this.maskShape.scaleX = 1;
                return;
            }
            this.maskShape.scaleX = param1 / this._countDownTime;
            if (param1 == 0)
            {
                this.closeMe();
            }
            return;
        }// end function

        public function setKillsInfo(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._level = param1;
            var _loc_5:* = BatterModel.getInstance().getInfoFromId(param1);
            var _loc_6:* = BatterModel.getInstance().getInfoFromId((param1 + 1));
            _loc_6 = BatterModel.getInstance().getInfoFromId((param1 + 1)) == null ? (_loc_5) : (_loc_6);
            var _loc_7:* = BatterModel.getInstance().getMaxInfo();
            this._countDownTime = param4;
            this.setExpRate(_loc_5.q_exp / 100);
            this.imgKillCount.setNumber(param2);
            this.downTime.count = this._countDownTime;
            this.startEffect();
            if (param2 == 0)
            {
                this.closeMe();
            }
            else
            {
                this.openMe();
            }
            var _loc_8:* = BATTER_TIPS_WORD;
            _loc_8 = _loc_8.replace("{1}", param2);
            _loc_8 = _loc_8.replace("{2}", _loc_5.q_exp / 100);
            _loc_8 = _loc_8.replace("{3}", _loc_6.q_evencut_num);
            _loc_8 = _loc_8.replace("{4}", _loc_6.q_exp / 100);
            StringTip.update(this, _loc_8);
            return;
        }// end function

        private function setExpRate(param1:int) : void
        {
            this.expRate.visible = param1 > 0 ? (true) : (false);
            var _loc_2:* = this.expRate.getChildByName("num1") as MovieClip;
            var _loc_3:* = this.expRate.getChildByName("num2") as MovieClip;
            var _loc_4:* = this.expRate.getChildByName("num3") as MovieClip;
            var _loc_5:* = param1 % 1000;
            if (param1 % 1000 >= 100)
            {
                _loc_2.gotoAndStop((int(_loc_5 / 100) + 1));
            }
            else
            {
                _loc_2.gotoAndStop(11);
            }
            _loc_5 = _loc_5 % 100;
            if (_loc_5 >= 10)
            {
                _loc_3.gotoAndStop((int(_loc_5 / 10) + 1));
            }
            else
            {
                _loc_3.gotoAndStop(param1 >= 100 ? (1) : (11));
            }
            _loc_5 = _loc_5 % 10;
            _loc_4.gotoAndStop((_loc_5 + 1));
            return;
        }// end function

        private function startEffect() : void
        {
            this.vmcFire.play();
            this.vmcSword.play();
            this.vmcWater.play();
            this.imgKillCount.alpha = 0.75;
            this.imgKillCount.scaleX = 1;
            this.imgKillCount.scaleY = 1;
            this.imgKillCount.move(-48, -20);
            if (this.timeLine)
            {
                this.timeLine.setEnabled(false);
                this.timeLine = null;
            }
            TweenLite.killTweensOf(this.imgKillCount);
            this.timeLine = new TimelineLite();
            this.timeLine.append(new TweenLite(this.imgKillCount, 0.17, {alpha:1, scaleX:0.6, scaleY:0.6, x:-48, y:-20, ease:Back.easeOut}));
            this.timeLine.append(new TweenLite(this.imgKillCount, 2.5, {}));
            if (MapObj.getInstance().mapID != Params.COUNTRY_MAP_ID)
            {
                this.timeLine.append(new TweenLite(this.imgKillCount, 0.5, {alpha:0, ease:Back.easeOut, y:-30, onComplete:function () : void
            {
                vmcRay.visible = false;
                imgKillCount.alpha = 0;
                return;
            }// end function
            }));
            }
            this.vmcRay.loadRes("res/effect/batterray.png");
            this.vmcRay.auto = true;
            this.vmcRay.updatePose("90", false);
            this.vmcRay.visible = true;
            this.vmcswordLight.loadRes("res/effect/swordeffect.png");
            this.vmcswordLight.auto = true;
            this.vmcswordLight.updatePose("90", false);
            return;
        }// end function

        public function openMe() : void
        {
            if (!this.parent)
            {
                Global.mainUIManager.addUI(this, null, 0, true);
                this.x = 6;
                this.y = 301;
                this.loaderEffect();
            }
            return;
        }// end function

        public function closeMe() : void
        {
            this.cleanEffect();
            if (this.parent)
            {
                Global.mainUIManager.removeUI(this);
            }
            return;
        }// end function

        private function cleanEffect() : void
        {
            this.vmcSword.finalize();
            this.vmcFire.finalize();
            this.vmcWater.finalize();
            return;
        }// end function

    }
}
