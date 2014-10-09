package com.f1.manager.pop
{
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.interfaces.manager.*;
    import com.f1.interfaces.ui.box.*;
    import com.f1.manager.keyboard.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.events.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.f1.vmc.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class PopManager extends Object implements IPopManager
    {
        private var bgMask:DisplayObject;
        private var _txtCue:TextField;
        private var mainScreen:BaseSprite;
        private var _popLayer:BaseSprite;
        private var _cueLayer:BaseSprite;
        private var _popupLayer:BaseSprite;
        private var _tipsLayer:BaseSprite;
        private var _txtLayer:BaseSprite;
        private var _popMaskLayer:BaseSprite;
        private var _cueMaskLayer:BaseSprite;
        private var _cueBox:BaseBox;
        private var _fightEffect:VMCView;
        private var _fightBombEffect:VMCView;
        private var _marqueeTop:Marquee;
        private var _marquee:IMarquee;
        private var _marqueeRomor:IMarquee;
        private var _scrollSystemCue:ScrollSystemCue;
        private var _scrollFightCue:ScrollSystemCue;
        private var _scrollMouseCue:ScrollSystemCue;
        private var _statusSystemCue:StatusSystemCue;
        private var _serverHitCue:ServerHitCue;
        private var _dragLayer:BaseSprite;
        private var _bossHomeTargetX:int;
        private var _bossHomeTargetY:int;
        private var _fightBossHomeEffect:VMCView;
        private var bosshomeTimer:Timer;
        private var timer:Timer;
        private var targetX:Number;
        private var targetY:Number;
        private var easing:Number = 0.2;
        private var progressBox:UILoadingBox;
        private var _mcBuff:Array;
        private var hidedGroup:int = -1;
        private var UIList:Array;
        private static const INTER:uint = 20;
        private static const SHOW_TIME:Number = 0.2;
        private static const LAYOUT_TWEEN_TIME:Number = 0.2;
        public static const FONT2:String = "宋体";
        public static const BOX_RELATIONSHIP_CRASH:uint = 1;
        public static const BOX_RELATIONSHIP_PEACE:uint = 2;
        public static const BOX_RELATIONSHIP_COMBINE:uint = 3;

        public function PopManager(param1:BaseScene)
        {
            this.bosshomeTimer = new Timer(33);
            this.timer = new Timer(33);
            this._mcBuff = [];
            this.UIList = [];
            this.mainScreen = param1;
            this._popMaskLayer = param1.createLayer();
            this._popLayer = param1.createLayer();
            this._popupLayer = param1.createLayer();
            this._dragLayer = (this.mainScreen as BaseScene).createLayer();
            this._tipsLayer = (this.mainScreen as BaseScene).createLayer();
            this._txtLayer = (this.mainScreen as BaseScene).createLayer();
            this._cueMaskLayer = param1.createLayer();
            this._cueLayer = param1.createLayer();
            this.bgMask = ToolKit.creatRect(0, 0, 100, 100, 0, -1, 0.5);
            this.bgMask.alpha = 0;
            this.initTxtCue();
            this.initMarQuee();
            this.initScrollCue();
            this.resize();
            return;
        }// end function

        public function get scrollSystemCue() : ScrollSystemCue
        {
            return this._scrollSystemCue;
        }// end function

        public function set scrollSystemCue(param1:ScrollSystemCue) : void
        {
            this._scrollSystemCue = param1;
            return;
        }// end function

        public function get marquee() : IMarquee
        {
            return this._marquee;
        }// end function

        public function set marquee(param1:IMarquee) : void
        {
            this._marquee = param1;
            return;
        }// end function

        public function get marqueeRomor() : IMarquee
        {
            return this._marqueeRomor;
        }// end function

        public function set marqueeRomor(param1:IMarquee) : void
        {
            this._marqueeRomor = param1;
            return;
        }// end function

        public function get cueMaskLayer() : BaseSprite
        {
            return this._cueMaskLayer;
        }// end function

        public function set cueMaskLayer(param1:BaseSprite) : void
        {
            this._cueMaskLayer = param1;
            return;
        }// end function

        public function get txtLayer() : BaseSprite
        {
            return this._txtLayer;
        }// end function

        public function addDargLoayer(param1) : void
        {
            this._dragLayer.addChild(param1);
            return;
        }// end function

        public function get cueBox() : BaseBox
        {
            return this._cueBox;
        }// end function

        public function hideAllBox() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < this._popLayer.numChildren)
            {
                
                _loc_1 = this._popLayer.getChildAt(_loc_2) as BaseSprite;
                if (_loc_1 && _loc_1 is IBaseBox)
                {
                    (_loc_1 as IBaseBox).close();
                }
                _loc_2++;
            }
            return;
        }// end function

        private function initTxtCue() : void
        {
            this._txtCue = new TextField();
            this._txtCue.name = "txtCue";
            this._txtCue.mouseEnabled = false;
            this._txtCue.mouseWheelEnabled = false;
            var _loc_1:* = new TextFormat();
            _loc_1.align = "center";
            _loc_1.font = FONT2;
            _loc_1.bold = true;
            _loc_1.color = 16503646;
            _loc_1.size = 28;
            this._txtCue.defaultTextFormat = _loc_1;
            this._txtCue.width = this.mainScreen._w;
            this._txtCue.height = 200;
            this._txtCue.antiAliasType = AntiAliasType.ADVANCED;
            this._txtCue.selectable = false;
            this._txtCue.multiline = true;
            this._txtCue.wordWrap = true;
            this._txtCue.filters = [FrameworkGlobal.BLACK_FILTER];
            this._txtCue.alpha = 0;
            this._txtLayer.addChild(this._txtCue);
            return;
        }// end function

        public function txtCue(param1:String, param2:Number = 2) : void
        {
            var _loc_3:* = null;
            Log.log(param1);
            if (param1 != null)
            {
                if (param2 > 0)
                {
                    TweenLite.killTweensOf(this._txtCue);
                    if (param1 != this._txtCue.htmlText)
                    {
                        this._txtCue.htmlText = param1;
                    }
                    if (param1 != "")
                    {
                        _loc_3 = new TimelineLite();
                        _loc_3.append(new TweenLite(this._txtCue, 0.3, {alpha:1}));
                        _loc_3.append(new TweenLite(this._txtCue, param2, {}));
                        _loc_3.append(new TweenLite(this._txtCue, 0.3, {alpha:0}));
                    }
                }
            }
            return;
        }// end function

        public function getTxtCueText() : String
        {
            if (this._txtCue && this._txtCue.text)
            {
                return this._txtCue.text;
            }
            return null;
        }// end function

        public function clearTxtCue() : void
        {
            this._txtCue.text = "";
            return;
        }// end function

        public function getBgMask() : DisplayObject
        {
            return this.bgMask;
        }// end function

        public function addBgMask(param1:Boolean = false, param2:Boolean = false) : void
        {
            if (param1)
            {
                this._cueMaskLayer.addChild(this.bgMask);
            }
            else
            {
                this._popMaskLayer.addChild(this.bgMask);
            }
            if (!param2)
            {
                this.bgMask.alpha = 0;
            }
            else
            {
                this.bgMask.alpha = 0.5;
            }
            KeyboardManager.freezeListener();
            return;
        }// end function

        public function removeBgMask() : void
        {
            if (this.bgMask && this.bgMask.parent)
            {
                this.bgMask.parent.removeChild(this.bgMask);
            }
            KeyboardManager.unfreezeListener();
            return;
        }// end function

        public function returnScrollSystemBack() : void
        {
            if (this.scrollSystemCue && this._scrollSystemCue.parent != this._txtLayer)
            {
                this._scrollSystemCue.move(FrameworkGlobal.stageW / 2, FrameworkGlobal.stageH - 335);
                this._txtLayer.addChild(this._scrollSystemCue);
            }
            return;
        }// end function

        private function initScrollCue() : void
        {
            this._scrollFightCue = new ScrollSystemCue(ScrollSystemCue.FIGHT_NOTICE);
            this._scrollSystemCue = new ScrollSystemCue(ScrollSystemCue.SYSTEM_NOTICE);
            this._scrollMouseCue = new ScrollSystemCue(ScrollSystemCue.MOUSE_RESPOND);
            this._statusSystemCue = new StatusSystemCue();
            this._serverHitCue = new ServerHitCue();
            this._txtLayer.addChild(this._serverHitCue);
            this._txtLayer.addChild(this._scrollFightCue);
            this._txtLayer.addChild(this._scrollSystemCue);
            this.mainScreen.addChild(this._scrollMouseCue);
            this._txtLayer.addChild(this._statusSystemCue);
            this._statusSystemCue.move(FrameworkGlobal.stageW / 2, FrameworkGlobal.stageH / 2);
            this._scrollSystemCue.move(FrameworkGlobal.stageW / 2, FrameworkGlobal.stageH - 335);
            this._scrollFightCue.move(FrameworkGlobal.stageW / 2 - 120, FrameworkGlobal.stageH / 2 - 90);
            return;
        }// end function

        private function initMarQuee() : void
        {
            this._marqueeTop = new Marquee();
            this._txtLayer.addChild(this._marqueeTop);
            return;
        }// end function

        public function addedToMarQueeTop(param1:String) : void
        {
            this._marqueeTop.marquee(param1);
            this.mainScreen.layoutMC(this._marqueeTop, Layout.TOP_CENTER, 0, 0);
            return;
        }// end function

        public function addToMainScreen(param1:DisplayObject, param2:LayoutInfo) : void
        {
            if (param1.parent != this._txtLayer)
            {
                this._txtLayer.addChild(param1);
            }
            this._txtLayer.layoutMC(param1, param2.type, param2.offsetX, param2.offsetY);
            return;
        }// end function

        public function addedToSystem(param1:String) : void
        {
            this._scrollSystemCue.addedScrollInfo(param1);
            return;
        }// end function

        public function addedToFight(param1:String) : void
        {
            this._scrollFightCue.addedScrollInfo(param1);
            this._scrollFightCue.move(FrameworkGlobal.stageW / 2 - 120, FrameworkGlobal.stageH / 2 - 90);
            return;
        }// end function

        public function addedToStatus(param1:String) : void
        {
            this._statusSystemCue.addInfoToCue(param1);
            return;
        }// end function

        public function addedToMouseCue(param1:String) : void
        {
            this._scrollMouseCue.addedScrollInfo(param1);
            return;
        }// end function

        public function addedServerToCue(param1:ServerHitIcon) : void
        {
            this._serverHitCue.addServerToList(param1);
            this._txtLayer.layoutMC(this._serverHitCue, Layout.BOTTOM_CENTER, 0, 141);
            return;
        }// end function

        public function addedServerToCueCount(param1:ServerHitIcon, param2:int) : void
        {
            var _loc_3:* = this.getServerToCue("mailservericon");
            var _loc_4:* = _loc_3 ? (true) : (false);
            this._serverHitCue.addServerToListCount(param1, param2);
            if (!_loc_4)
            {
                this._txtLayer.layoutMC(this._serverHitCue, Layout.BOTTOM_CENTER, 0, 141);
            }
            return;
        }// end function

        public function getServerToCue(param1:String) : ServerHitIcon
        {
            return this._serverHitCue.getServerIcon(param1);
        }// end function

        public function removeServerToCue(param1:ServerHitIcon) : void
        {
            this._serverHitCue.removeServerFromList(param1);
            this._txtLayer.layoutMC(this._serverHitCue, Layout.BOTTOM_CENTER, 0, 141);
            return;
        }// end function

        public function removeServerFromCue() : void
        {
            this._serverHitCue.cleanAllServer();
            return;
        }// end function

        public function addedPKTips(param1:DisplayObject) : void
        {
            this._tipsLayer.addChild(param1);
            (param1 as IBaseBox).setAttr("layoutInfo", new LayoutInfo(Layout.BOTTOM_CENTER, 0, 100));
            this.mainScreen.layoutMC(param1, Layout.BOTTOM_CENTER, 0, 100);
            return;
        }// end function

        public function addedMapNameTips(param1:DisplayObject) : void
        {
            param1.name = "map";
            this._tipsLayer.addChild(param1);
            return;
        }// end function

        public function addedChangeJobEffect(param1:DisplayObject) : void
        {
            this._tipsLayer.addChild(param1);
            return;
        }// end function

        public function addedFightTips(param1:DisplayObject, param2:String) : void
        {
            this._tipsLayer.addChild(param1);
            var _loc_3:* = new ImgNumber();
            param1["imgNumber"].addChild(_loc_3);
            _loc_3.setNumberScroll(param2, 1);
            param1.alpha = 0;
            var _loc_4:* = (FrameworkGlobal.stage.stageWidth - param1.width) / 2;
            var _loc_5:* = FrameworkGlobal.stage.stageHeight / 2;
            var _loc_6:* = FrameworkGlobal.stage.stageWidth / 2;
            var _loc_7:* = FrameworkGlobal.stage.stageHeight / 2;
            param1.x = _loc_4;
            param1.y = _loc_5;
            var _loc_8:* = new TimelineLite();
            _loc_8.append(new TweenLite(param1, 0.3, {alpha:1, onComplete:this.onAlphaComplete, onCompleteParams:[param1]}));
            _loc_8.append(new TweenLite(param1, 1, {}));
            _loc_8.append(new TweenLite(param1, 0.15, {x:_loc_6, y:_loc_7, scaleX:0, scaleY:0, onComplete:this.onComplete, onCompleteParams:[param1, _loc_6, _loc_7]}));
            return;
        }// end function

        private function onAlphaComplete(param1:DisplayObject) : void
        {
            this.addFireEffect(param1["effect"] as DisplayObjectContainer);
            return;
        }// end function

        private function addFireEffect(param1:DisplayObjectContainer) : void
        {
            var _loc_2:* = null;
            if (_loc_2 == null)
            {
                _loc_2 = new VMCView();
                _loc_2.auto = true;
                _loc_2.loadRes("res/effect/fightFire.png");
            }
            param1.addChild(_loc_2);
            _loc_2.updatePose("90", true);
            _loc_2.move(0, 0);
            _loc_2.play();
            return;
        }// end function

        private function onComplete(param1:DisplayObject, param2:Number, param3:Number) : void
        {
            if (param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            this.showFightEffect(param2, param3);
            return;
        }// end function

        public function flyBossHomeIcon(param1:int, param2:int) : void
        {
            if (this._fightBossHomeEffect == null)
            {
                this._fightBossHomeEffect = new VMCView();
                this._fightBossHomeEffect.auto = true;
            }
            this._fightBossHomeEffect.loadRes("res/effect/fightEffect.png");
            if (this._fightBossHomeEffect.parent == null)
            {
                this._tipsLayer.addChild(this._fightBossHomeEffect);
            }
            this._fightBossHomeEffect.updatePose("90", false, false, true);
            this._fightBossHomeEffect.move(param1, param2);
            this._fightBossHomeEffect.replay();
            var _loc_3:* = 238;
            var _loc_4:* = 167;
            this._bossHomeTargetX = _loc_3;
            this._bossHomeTargetY = _loc_4;
            this.bosshomeTimer.addEventListener(TimerEvent.TIMER, this.onBossHomeMove);
            this.bosshomeTimer.start();
            return;
        }// end function

        private function onBossHomeMove(event:Event) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_2:* = this._bossHomeTargetX - this._fightBossHomeEffect.x;
            var _loc_3:* = this._bossHomeTargetY - this._fightBossHomeEffect.y;
            if (Math.sqrt(_loc_2 * _loc_2 + _loc_3 * _loc_3) < 1)
            {
                this.bosshomeTimer.removeEventListener(TimerEvent.TIMER, this.onMove);
                this.bosshomeTimer.stop();
                return;
            }
            if (Math.sqrt(_loc_2 * _loc_2 + _loc_3 * _loc_3) < 1)
            {
                this._fightBossHomeEffect.move(this.targetX, this.targetY);
            }
            else
            {
                _loc_4 = _loc_2 * 0.12;
                _loc_5 = _loc_3 * 0.1;
                _loc_6 = this._fightBossHomeEffect._x + _loc_4;
                _loc_7 = this._fightBossHomeEffect._y + _loc_5;
                this._fightBossHomeEffect.move(_loc_6, _loc_7);
            }
            return;
        }// end function

        private function showFightEffect(param1:int, param2:int) : void
        {
            if (this._fightEffect == null)
            {
                this._fightEffect = new VMCView();
                this._fightEffect.auto = true;
            }
            this._fightEffect.loadRes("res/effect/fightEffect.png");
            if (this._fightEffect.parent == null)
            {
                this._tipsLayer.addChild(this._fightEffect);
            }
            this._fightEffect.updatePose("90", false, false, true);
            this._fightEffect.move(param1, param2);
            this._fightEffect.replay();
            var _loc_3:* = 150;
            var _loc_4:* = 30;
            this.targetX = _loc_3;
            this.targetY = _loc_4;
            this.timer.addEventListener(TimerEvent.TIMER, this.onMove);
            TweenLite.delayedCall(1.2, this.showFightBombEffect, [this.targetX + 50, this.targetY + 50]);
            this.timer.start();
            return;
        }// end function

        private function onMove(event:Event) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_2:* = this.targetX - this._fightEffect.x;
            var _loc_3:* = this.targetY - this._fightEffect.y;
            if (Math.sqrt(_loc_2 * _loc_2 + _loc_3 * _loc_3) < 1)
            {
                this.timer.removeEventListener(TimerEvent.TIMER, this.onMove);
                this.timer.stop();
                return;
            }
            if (Math.sqrt(_loc_2 * _loc_2 + _loc_3 * _loc_3) < 1)
            {
                this._fightEffect.move(this.targetX, this.targetY);
            }
            else
            {
                _loc_4 = _loc_2 * 0.12;
                _loc_5 = _loc_3 * 0.1;
                _loc_6 = this._fightEffect._x + _loc_4;
                _loc_7 = this._fightEffect._y + _loc_5;
                this._fightEffect.move(_loc_6, _loc_7);
            }
            return;
        }// end function

        private function showFightBombEffect(param1:int, param2:int) : void
        {
            if (this._fightBombEffect == null)
            {
                this._fightBombEffect = new VMCView();
                this._fightBombEffect.loadRes("res/effect/fightEffectBomb.png");
                this._fightBombEffect.auto = true;
            }
            if (this._fightBombEffect.parent == null)
            {
                this._tipsLayer.addChild(this._fightBombEffect);
            }
            this._fightBombEffect.updatePose("90", false, false, true);
            this._fightBombEffect.move(param1, param2);
            this._fightBombEffect.play();
            FrameworkGlobal.sendMsg(new Event("fight_up"));
            return;
        }// end function

        public function addGuideDisplayObject(param1:DisplayObject) : void
        {
            this._tipsLayer.addChild(param1);
            return;
        }// end function

        public function addTips(param1:DisplayObject, param2:LayoutInfo) : void
        {
            this._tipsLayer.addChild(param1);
            (param1 as IBaseSprite).setAttr("layoutInfo", param2);
            this.mainScreen.layoutMC(param1, param2.type, param2.offsetX, param2.offsetY);
            return;
        }// end function

        public function removeTips(param1:DisplayObject) : void
        {
            if (param1.parent == this._tipsLayer)
            {
                this._tipsLayer.removeChild(param1);
            }
            return;
        }// end function

        public function cue(param1:String = "", param2:String = null, param3:Array = null, param4:Function = null, param5:Function = null, param6:uint = 2, param7 = null, param8:Boolean = false, param9:Boolean = false, param10:Function = null, param11:Boolean = true) : BaseBox
        {
            if (param1 == null)
            {
                LanguageCfgObj.getInstance().getByIndex("11635");
            }
            Log.log(param1);
            if (param2 == null)
            {
                param2 = "";
            }
            if (this.hasEqual(param1, param4, param5))
            {
                Log.log("已经有相同的弹窗了");
                return null;
            }
            var _loc_12:* = new SysCueBox("new_sys_cue_box1");
            _loc_12.autoClose = param8;
            this.addPop(_loc_12, true, false, true, true, false, true);
            _loc_12.cue(param1, param2, param3, param4, param5, param6, param7, param9, param10);
            _loc_12.closeBtnVisible = param11;
            this._cueBox = _loc_12;
            return _loc_12;
        }// end function

        private function hasEqual(param1:String = "", param2:Function = null, param3:Function = null) : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_4:* = this._cueLayer.numChildren;
            if (this._cueLayer.numChildren > 0)
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_5 = this._cueLayer.getChildAt(_loc_6) as ICueBox;
                    if (_loc_5)
                    {
                        _loc_7 = new TextField();
                        _loc_7.htmlText = param1;
                        param1 = _loc_7.text;
                        if (_loc_5.getTxt() == param1 && _loc_5.yesFun == null && param2 == null && _loc_5.noFun == null && param3 == null)
                        {
                            return true;
                        }
                    }
                    _loc_6++;
                }
            }
            return false;
        }// end function

        public function getBox(param1:String)
        {
            var _loc_2:* = this._popLayer.getChildByName(param1) as IBaseBox;
            if (!_loc_2)
            {
                Log.log("得不到盒子--", param1);
            }
            return _loc_2;
        }// end function

        public function delBox(param1) : void
        {
            if (param1 is DisplayObject)
            {
                param1 = param1 as IBaseBox;
            }
            else if (param1 is String)
            {
                param1 = this._popLayer.getChildByName(param1) as IBaseBox;
            }
            this.removeBox(param1);
            return;
        }// end function

        public function resize() : void
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_1:* = FrameworkGlobal.stageW;
            var _loc_2:* = FrameworkGlobal.stageH;
            if (this.bgMask != null)
            {
                this.bgMask.width = this.mainScreen._w;
                this.bgMask.height = this.mainScreen._h;
            }
            var _loc_3:* = this._cueLayer.numChildren;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = this._cueLayer.getChildAt(_loc_5) as IBaseBox;
                if (_loc_5 > 0)
                {
                    _loc_9 = this._cueLayer.getChildAt((_loc_5 - 1));
                    _loc_4.move(int(_loc_9.x + INTER), int(_loc_9.y + INTER));
                }
                else
                {
                    _loc_4.move(int((_loc_1 - _loc_4._w) / 2), int((_loc_2 - _loc_4._h) / 2));
                }
                _loc_5++;
            }
            _loc_3 = this._popLayer.numChildren;
            _loc_5 = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = this._popLayer.getChildAt(_loc_5) as IBaseBox;
                _loc_6 = _loc_4.getAttr("layoutInfo");
                _loc_7 = _loc_4.getAttr("centerPop");
                if (_loc_7)
                {
                    _loc_4.move(int((_loc_1 - _loc_4._w) / 2), int((_loc_2 - _loc_4._h) / 2));
                }
                else if (_loc_4.getAttr("smallCueLayout"))
                {
                    _loc_10 = _loc_4.getAttr("smallCueLayout") as LayoutInfo;
                    if (_loc_10 && _loc_4 is DisplayObject)
                    {
                        this.mainScreen.layoutMC(_loc_4 as DisplayObject, _loc_10.type, _loc_10.offsetX, _loc_10.offsetY);
                    }
                }
                else if (_loc_6)
                {
                    this.layoutBox(_loc_4);
                }
                _loc_5++;
            }
            _loc_3 = this._tipsLayer.numChildren;
            var _loc_8:* = 0;
            while (_loc_8 < this._tipsLayer.numChildren)
            {
                
                _loc_11 = this._tipsLayer.getChildAt(_loc_8);
                _loc_4 = _loc_11 as IBaseBox;
                if (_loc_4)
                {
                    _loc_6 = _loc_4.getAttr("layoutInfo");
                    if (_loc_6)
                    {
                        this.mainScreen.layoutMC(_loc_11, _loc_6.type, _loc_6.offsetX, _loc_6.offsetY);
                    }
                }
                else if (_loc_11.name == "map")
                {
                    this.mainScreen.layoutMC(_loc_11, Layout.CENTER, 0, -180);
                }
                else
                {
                    _loc_6 = null;
                    if (_loc_11 is IBaseSprite)
                    {
                        _loc_6 = (_loc_11 as IBaseSprite).getAttr("layoutInfo");
                    }
                    if (_loc_6)
                    {
                        this.mainScreen.layoutMC(_loc_11, _loc_6.type, _loc_6.offsetX, _loc_6.offsetY);
                    }
                    else
                    {
                        this.mainScreen.layoutMC(_loc_11, Layout.CENTER);
                    }
                }
                _loc_8++;
            }
            this._txtCue.width = this.mainScreen._w;
            this._txtLayer.setWH(_loc_1, _loc_2);
            this._cueLayer.setWH(_loc_1, _loc_2);
            this._popupLayer.setWH(_loc_1, _loc_2);
            this.resizePopup();
            this._dragLayer.setWH(_loc_1, _loc_2);
            this._cueMaskLayer.setWH(_loc_1, _loc_2);
            this._tipsLayer.setWH(_loc_1, _loc_2);
            this.mainScreen.layoutMC(this._txtCue, 1, 0, -50);
            this.mainScreen.layoutMC(this._marqueeTop, Layout.TOP_CENTER, 0, 0);
            if (this._marquee && this._marqueeRomor)
            {
                this._marquee.resize();
                this._marqueeRomor.resize();
            }
            this._statusSystemCue.move(FrameworkGlobal.stageW / 2, FrameworkGlobal.stageH / 2);
            if (this._scrollSystemCue.parent == this._txtLayer)
            {
                this._scrollSystemCue.move(FrameworkGlobal.stageW / 2, FrameworkGlobal.stageH - 335);
            }
            this._scrollFightCue.move(FrameworkGlobal.stageW / 2 - 120, FrameworkGlobal.stageH / 2 - 90);
            if (this.progressBox && this.progressBox.isOpen)
            {
                this.mainScreen.layoutMC(this.progressBox);
            }
            this._txtLayer.layoutMC(this._serverHitCue, Layout.BOTTOM_CENTER, 0, 141);
            return;
        }// end function

        private function resizePopup() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._popupLayer.scaleX;
            if (_loc_1 != 1)
            {
                this._popupLayer.scaleX = 1;
                this._popupLayer.scaleY = 1;
            }
            var _loc_2:* = this._popupLayer.numChildren;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_3 = BaseSprite(this._popupLayer.getChildAt(_loc_5));
                if (!_loc_3)
                {
                }
                else
                {
                    _loc_4 = _loc_3.getAttr("layoutInfo");
                    if (_loc_4)
                    {
                        this._popupLayer.layoutMC(_loc_3, _loc_4.type, _loc_4.offsetX, _loc_4.offsetY);
                    }
                    _loc_3.resize();
                }
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_1 != 1)
            {
                this._popupLayer.scaleX = _loc_1;
            }
            return;
        }// end function

        private function layoutBox(param1:IBaseBox) : void
        {
            var _loc_2:* = param1.getAttr("layoutInfo");
            if (_loc_2)
            {
                this.mainScreen.layoutMC(param1.getSprite(), _loc_2.type, _loc_2.offsetX, _loc_2.offsetY);
            }
            return;
        }// end function

        public function addPop(param1:IBaseBox, param2:Boolean = false, param3:Boolean = false, param4:Boolean = true, param5:Boolean = true, param6:Boolean = false, param7:Boolean = false, param8:LayoutInfo = null, param9:Number = 0.5) : void
        {
            Log.log("加入一个盒子", param1);
            param1.setAttr("inCueLayer", param7);
            param1.setAttr("hasMask", param2);
            param1.setAttr("blackMask", param3);
            param1.setAttr("centerPop", param4);
            param1.setAttr("alphaPop", param5);
            param1.setAttr("scalePop", param6);
            param1.setAttr("layoutInfo", param8);
            param1.setAttr("alpha", param9);
            param1.addEvtListener(BoxEvent.SHOW_HIDE, this.__showHideBox);
            param1.addEvtListener(MouseEvent.MOUSE_DOWN, this.__showUp, false, false);
            return;
        }// end function

        public function removeBox(param1:IBaseBox) : void
        {
            param1.removeEvtListener(BoxEvent.SHOW_HIDE, this.__showHideBox);
            param1.removeEvtListener(MouseEvent.MOUSE_DOWN, this.__showUp);
            param1.removeFromParent();
            param1.finalize();
            return;
        }// end function

        public function getLayerOfBox(param1:IBaseBox) : BaseSprite
        {
            if (param1.getAttr("inCueLayer"))
            {
                return this._cueLayer;
            }
            return this._popLayer;
        }// end function

        private function __showUp(event:MouseEvent = null) : void
        {
            var _loc_2:* = event.currentTarget as IBaseBox;
            var _loc_3:* = this.getLayerOfBox(_loc_2);
            var _loc_4:* = _loc_3.numChildren - 1;
            if (_loc_2.getParent() == _loc_3)
            {
                if (_loc_3.getChildIndex(_loc_2.getSprite()) != _loc_4)
                {
                    _loc_3.setChildIndex(_loc_2.getSprite(), _loc_4);
                }
                _loc_2.changeToActive();
            }
            return;
        }// end function

        private function __showHideBox(event:BoxEvent = null) : void
        {
            var _loc_2:* = event.currentTarget as IBaseBox;
            if (event.showOrHide == BaseBox.SHOW)
            {
                if (_loc_2.UILoaded)
                {
                    this.showBox(_loc_2);
                }
                else
                {
                    _loc_2.addEvtListener(UIEvent.RES_LOAD_COMPLETE, this.__boxUILoaded);
                    _loc_2.progressFun = this.showLoadingBox();
                }
            }
            else
            {
                this.hideBox(_loc_2);
                if (FrameworkGlobal.stage.focus == _loc_2)
                {
                    FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
                }
            }
            return;
        }// end function

        public function showLoadingBox(param1:Boolean = false, param2:uint = 0, param3:Number = 0) : Function
        {
            if (!this.progressBox)
            {
                this.progressBox = new UILoadingBox();
            }
            this.addPop(this.progressBox, true, true, true, true, false, true, null, param3);
            this.progressBox.autoClose = param2;
            this.progressBox.open();
            if (param1)
            {
                this.bgMask.alpha = param3;
            }
            return this.progressBox.setProgress;
        }// end function

        public function closeLoadingBox() : void
        {
            if (this.progressBox)
            {
                this.progressBox.close();
            }
            return;
        }// end function

        public function get loadingBox() : UILoadingBox
        {
            if (!this.progressBox)
            {
                this.progressBox = new UILoadingBox();
            }
            return this.progressBox;
        }// end function

        private function __boxUILoaded(event:UIEvent) : void
        {
            this.closeLoadingBox();
            var _loc_2:* = event.currentTarget as IBaseBox;
            _loc_2.progressFun = null;
            this.showBox(_loc_2);
            return;
        }// end function

        private function boxRelationship(param1:IBaseBox = null, param2:Boolean = false) : void
        {
            var _loc_5:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = this._popLayer.numChildren;
            if (_loc_3 == 0)
            {
                return;
            }
            var _loc_4:* = [];
            var _loc_6:* = [];
            var _loc_8:* = 0;
            while (_loc_8 < _loc_3)
            {
                
                _loc_5 = IBaseBox(this._popLayer.getChildAt(_loc_8));
                if (_loc_5.getAttr("closing"))
                {
                }
                else
                {
                    if (!param1)
                    {
                        param1 = _loc_5;
                    }
                    if (param1 && _loc_5 != param1)
                    {
                        _loc_7 = this.check2BoxRelationship(param1, _loc_5);
                        if (_loc_7 == BOX_RELATIONSHIP_CRASH)
                        {
                            _loc_6.push(_loc_5);
                        }
                        else if (_loc_7 == BOX_RELATIONSHIP_COMBINE)
                        {
                            _loc_4.push(_loc_5);
                        }
                        else if (_loc_7 == BOX_RELATIONSHIP_PEACE)
                        {
                        }
                    }
                    else
                    {
                        _loc_4.push(_loc_5);
                    }
                }
                _loc_8++;
            }
            for each (_loc_5 in _loc_6)
            {
                
                _loc_5.close();
            }
            if (_loc_4.length > 1 || _loc_4.length > 0 && param2)
            {
                this.mainScreen.layoutGroup(_loc_4, 1, 0, 0, LAYOUT_TWEEN_TIME, 1);
                TweenLite.delayedCall(LAYOUT_TWEEN_TIME, this.layoutGroupComplete, [_loc_4]);
            }
            return;
        }// end function

        private function layoutGroupComplete(param1:Array) : void
        {
            var _loc_2:* = null;
            if (param1.length > 1)
            {
                for each (_loc_2 in param1)
                {
                    
                    _loc_2.dispatchEvent(new UIEvent(UIEvent.BOX_LAYOUT_COMPLETE));
                }
            }
            return;
        }// end function

        private function check2BoxRelationship(param1:IBaseBox, param2:IBaseBox) : uint
        {
            var _loc_3:* = getQualifiedClassName(param1);
            var _loc_4:* = getQualifiedClassName(param2);
            var _loc_5:* = param1.combinedBox.indexOf(_loc_4) > -1;
            var _loc_6:* = param2.combinedBox.indexOf(_loc_3) > -1;
            if (_loc_5 || _loc_6)
            {
                return BOX_RELATIONSHIP_COMBINE;
            }
            var _loc_7:* = param1.peaceBox.indexOf(_loc_4) > -1 || param1.peaceBox.indexOf("*") > -1;
            var _loc_8:* = param2.peaceBox.indexOf(_loc_3) > -1 || param2.peaceBox.indexOf("*") > -1;
            if (_loc_7 || _loc_8)
            {
                return BOX_RELATIONSHIP_PEACE;
            }
            return BOX_RELATIONSHIP_CRASH;
        }// end function

        private function showBox(param1:IBaseBox) : void
        {
            var _loc_10:* = NaN;
            var _loc_2:* = this.ifNeedMask(false);
            if (param1.getAttr("hasMask"))
            {
                if (param1.getAttr("inCueLayer"))
                {
                    this._cueMaskLayer.addChild(this.bgMask);
                }
                else
                {
                    this._popMaskLayer.addChild(this.bgMask);
                }
                _loc_10 = param1.getAttr("alpha");
                if (param1.getAttr("blackMask") || _loc_2)
                {
                    if (this.bgMask.alpha != _loc_10)
                    {
                        this.bgMask.alpha = _loc_10;
                    }
                }
                else if (this.bgMask.alpha != 0)
                {
                    this.bgMask.alpha = 0;
                }
                KeyboardManager.freezeListener();
            }
            else if (!_loc_2)
            {
                KeyboardManager.unfreezeListener();
            }
            param1.setAttr("showing", true);
            var _loc_3:* = param1.getAttr("layoutInfo");
            var _loc_4:* = param1.getAttr("centerPop");
            var _loc_5:* = param1.getAttr("alphaPop");
            var _loc_6:* = param1.getAttr("scalePop");
            var _loc_7:* = param1.getSprite();
            TweenLite.killTweensOf(_loc_7);
            var _loc_8:* = this.getLayerOfBox(param1);
            _loc_8.addChild(_loc_7);
            var _loc_9:* = {};
            if (_loc_5)
            {
                _loc_7.alpha = 0;
                _loc_9.alpha = 1;
            }
            if (_loc_6)
            {
                var _loc_11:* = 0.5;
                _loc_7.scaleY = 0.5;
                _loc_7.scaleX = _loc_11;
                _loc_9.scaleX = 1;
                _loc_9.scaleY = 1;
            }
            if (_loc_4)
            {
                this.mainScreen.layoutMC(_loc_7);
            }
            else if (_loc_3)
            {
                this.layoutBox(param1);
            }
            _loc_9.onComplete = this.showBoxComplete;
            _loc_9.onCompleteParams = [param1];
            TweenLite.to(_loc_7, SHOW_TIME, _loc_9);
            return;
        }// end function

        private function showBoxComplete(param1:IBaseBox) : void
        {
            param1.removeAttr("showing");
            if (this._popLayer == param1.getParent())
            {
                this.boxRelationship(param1);
            }
            return;
        }// end function

        private function hideBox(param1:IBaseBox) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_2:* = param1.getAttr("centerPop");
            var _loc_3:* = param1.getAttr("alphaPop");
            var _loc_4:* = param1.getAttr("scalePop");
            var _loc_5:* = param1.getSprite();
            TweenLite.killTweensOf(_loc_5);
            param1.setAttr("closing", true);
            if (!_loc_3 && !_loc_4)
            {
                this.hideBoxComplete(param1);
            }
            else if (_loc_4)
            {
                if (_loc_2)
                {
                    _loc_6 = this.mainScreen._w;
                    _loc_7 = this.mainScreen._h;
                    _loc_8 = int(_loc_6 / 2 - param1._w / 4);
                    _loc_9 = int(_loc_7 / 2 - param1._h / 4);
                    TweenLite.to(_loc_5, SHOW_TIME, {scaleX:0.5, scaleY:0.5, x:_loc_8, y:_loc_9, alpha:0, onComplete:this.hideBoxComplete, onCompleteParams:[_loc_5]});
                }
                else
                {
                    TweenLite.to(_loc_5, SHOW_TIME, {scaleX:0.5, scaleY:0.5, alpha:0, onComplete:this.hideBoxComplete, onCompleteParams:[_loc_5]});
                }
            }
            else if (_loc_3)
            {
                TweenLite.to(_loc_5, SHOW_TIME, {alpha:0, onComplete:this.hideBoxComplete, onCompleteParams:[_loc_5]});
            }
            return;
        }// end function

        private function hideBoxComplete(param1:IBaseBox) : void
        {
            param1.removeAttr("closing");
            if (this._popLayer == param1.getParent())
            {
                param1.removeFromParent();
                this.boxRelationship(null, true);
            }
            else
            {
                param1.removeFromParent();
            }
            if (param1.getAttr("hasMask"))
            {
                if (this.ifNeedMask())
                {
                    return;
                }
                if (this.bgMask && this.bgMask.parent)
                {
                    this.bgMask.parent.removeChild(this.bgMask);
                    KeyboardManager.unfreezeListener();
                }
            }
            return;
        }// end function

        private function ifNeedMask(param1:Boolean = true) : Boolean
        {
            var _loc_2:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            var _loc_3:* = this._cueLayer.numChildren;
            if (_loc_3 > 0)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_2 = this._cueLayer.getChildAt(_loc_5) as BaseSprite;
                    _loc_4 = _loc_2.getAttr("alpha");
                    if (_loc_2.getAttr("hasMask"))
                    {
                        if (param1)
                        {
                            if (_loc_2.getAttr("blackMask"))
                            {
                                if (this.bgMask.alpha != _loc_4)
                                {
                                    this.bgMask.alpha = _loc_4;
                                }
                            }
                            else if (this.bgMask.alpha != 0)
                            {
                                this.bgMask.alpha = 0;
                            }
                        }
                        if (this.bgMask.parent != this._cueMaskLayer)
                        {
                            this._cueMaskLayer.addChild(this.bgMask);
                            KeyboardManager.freezeListener();
                        }
                        return true;
                    }
                    _loc_5++;
                }
            }
            _loc_3 = this._popLayer.numChildren;
            if (_loc_3 > 0)
            {
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_2 = this._popLayer.getChildAt(_loc_5) as BaseSprite;
                    _loc_4 = _loc_2.getAttr("alpha");
                    if (_loc_2.getAttr("hasMask"))
                    {
                        if (param1)
                        {
                            if (_loc_2.getAttr("blackMask"))
                            {
                                this.bgMask.alpha = _loc_4;
                            }
                            else
                            {
                                this.bgMask.alpha = 0;
                            }
                        }
                        if (this.bgMask.parent != this._popMaskLayer)
                        {
                            this._popMaskLayer.addChild(this.bgMask);
                            KeyboardManager.freezeListener();
                        }
                        return true;
                    }
                    _loc_5++;
                }
            }
            KeyboardManager.unfreezeListener();
            return false;
        }// end function

        public function showMC(param1:DisplayObject, param2:Boolean) : void
        {
            if (param1 == null)
            {
                return;
            }
            var _loc_3:* = 3;
            if (param1 is MovieClip)
            {
                (param1 as MovieClip).mouseEnabled = false;
                (param1 as MovieClip).gotoAndStop(1);
                _loc_3 = (param1 as MovieClip).totalFrames / FrameworkGlobal.stage.frameRate;
            }
            var _loc_4:* = new Object();
            _loc_4.mc = param1;
            _loc_4.lastTime = _loc_3;
            _loc_4.isAutoDestroy = param2;
            this._mcBuff.push(_loc_4);
            if (this._mcBuff.length == 1)
            {
                this.showNextMc();
            }
            return;
        }// end function

        public function addUI(param1:BaseSprite, param2:LayoutInfo = null, param3:uint = 0, param4:Boolean = false) : void
        {
            if (!param1)
            {
                return;
            }
            if (this.UIList.indexOf(param1) == -1)
            {
                this.UIList.push(param1);
            }
            param1.setAttr("UIGroup", param3);
            if (param2)
            {
                param1.setAttr("layoutInfo", param2);
                this._popupLayer.layoutMC(param1, param2.type, param2.offsetX, param2.offsetY);
                if (param1 is Component)
                {
                    if (!Component(param1).UILoaded)
                    {
                        param1.addEvtListener(UIEvent.RESIZE, this.__UIResize);
                    }
                }
            }
            if (param4)
            {
                this._popupLayer.addChildAt(param1, 0);
            }
            else
            {
                this._popupLayer.addChild(param1);
            }
            if (this.hidedGroup == param3)
            {
                this.doHideUI(param1);
            }
            return;
        }// end function

        public function layoutUI(param1:BaseSprite) : void
        {
            var _loc_2:* = param1.getAttr("layoutInfo");
            if (_loc_2)
            {
                this._popupLayer.layoutMC(param1, _loc_2.type, _loc_2.offsetX, _loc_2.offsetY);
            }
            return;
        }// end function

        public function removeUI(param1:BaseSprite) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param1 && param1.parent == this._popupLayer)
            {
                this._popupLayer.removeChild(param1);
                FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
                _loc_2 = this.UIList.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    _loc_3 = this.UIList[_loc_4];
                    if (_loc_3 == param1)
                    {
                        this.UIList.splice(_loc_4, 1);
                        break;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            return;
        }// end function

        public function hideGroup(param1:uint) : void
        {
            var _loc_2:* = null;
            this.hidedGroup = param1;
            for each (_loc_2 in this.UIList)
            {
                
                if (_loc_2 && _loc_2.getAttr("UIGroup") == param1)
                {
                    this.doHideUI(_loc_2);
                }
            }
            return;
        }// end function

        private function __UIResize(event:Event) : void
        {
            var _loc_2:* = BaseSprite(event.currentTarget);
            var _loc_3:* = _loc_2.getAttr("layoutInfo");
            if (_loc_3)
            {
                this._popupLayer.layoutMC(_loc_2, _loc_3.type, _loc_3.offsetX, _loc_3.offsetY);
            }
            return;
        }// end function

        private function doHideUI(param1:BaseSprite) : void
        {
            if (param1.visible != false)
            {
                param1.visible = false;
            }
            return;
        }// end function

        private function doShowUI(param1:BaseSprite) : void
        {
            if (param1.visible != true)
            {
                param1.visible = true;
            }
            return;
        }// end function

        private function showNextMc() : void
        {
            if (this._mcBuff.length < 1)
            {
                return;
            }
            var _loc_1:* = this._mcBuff[0];
            if (_loc_1 == null)
            {
                return;
            }
            var _loc_2:* = _loc_1.mc;
            var _loc_3:* = _loc_1.lastTime;
            if (_loc_2 == null)
            {
                return;
            }
            Layout.layoutMC(FrameworkGlobal.stage, _loc_2, Layout.CENTER, 0, -100);
            FrameworkGlobal.stage.addChild(_loc_2);
            if (_loc_2 is MovieClip)
            {
                (_loc_2 as MovieClip).gotoAndPlay(1);
            }
            if (_loc_3 > 0 && _loc_1.isAutoDestroy)
            {
                TweenLite.delayedCall(_loc_3, this.hideMC, [_loc_2]);
            }
            return;
        }// end function

        public function hideMC(param1:DisplayObject) : void
        {
            var _loc_2:* = null;
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
                if (param1 is MovieClip)
                {
                    MovieClip(param1).stop();
                }
            }
            var _loc_3:* = 0;
            while (_loc_3 < this._mcBuff.length)
            {
                
                _loc_2 = this._mcBuff[_loc_3];
                if (param1 == _loc_2.mc)
                {
                    this._mcBuff.splice(_loc_3, 1);
                }
                _loc_3++;
            }
            if (this._mcBuff.length >= 1)
            {
                this.showNextMc();
            }
            return;
        }// end function

        public function finalize() : void
        {
            return;
        }// end function

    }
}
