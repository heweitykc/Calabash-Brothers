package com.game.zones.view.awards
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.backpack.bean.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesAwardsPanel extends BaseBox implements IGuide
    {
        private const HIT_OPEN_CARDS:String;
        private var _btnClose:BaseButton;
        private var _btnSure:BaseButton;
        private var _btnLeave:BaseButton;
        private var _txtAwardsInfo:TextField;
        private var _txtGateLeft:TextField;
        private var _freshFirstTime:MovieClip;
        private var _cardContainer:BaseSprite;
        private var _starContainer:Sprite;
        private var _magicRoll:MovieClip;
        private var _sealLevel:MovieClip;
        private var _tileSuccess:MovieClip;
        private var _tileDefeat:MovieClip;
        private var _fruitGlod:ImgNumber;
        private var _fruitExp:ImgNumber;
        private var _fruitSpirit:ImgNumber;
        private var _vecStar:Vector.<MovieClip>;
        private var _playerPhoto:MovieClip;
        private var _vecCard:Vector.<ZonesAwardsCard>;
        private var _awardHbox:HBox;
        private var _backBlackUp:Shape;
        private var _backBlackDown:Shape;
        private var count:int = 0;
        private var giftExp:Number;
        private var giftGold:int;
        private var giftSpirit:int;
        private var _isPass:Boolean = true;
        private var _isCards:Boolean;
        private var timeline:TimelineLite;
        private var _mcAwardMoney:Sprite;
        private var _mcAwardExp:Sprite;
        private var _mcAwardSpirit:Sprite;
        private var _mcAwardTools:Sprite;
        private var curStar:int = 0;
        private var _back:MovieClip;
        private var vmcBrushLight:VMCView;

        public function ZonesAwardsPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.HIT_OPEN_CARDS = LanguageCfgObj.getInstance().getByIndex("11488");
            _peaceBox = ["*"];
            loadDisplay("res/zonesawards.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("zonesawards", 0);
            this.initUI();
            this.addEvents();
            super.displayReady();
            this.registerGuide();
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_END_BELIA_WORLD)) == 0 && _loc_1.zones_type == ZoneType.ZONES_BELIAL_WORLD)
            {
                GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().FIRST_END_BELIA_WORLD));
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_END_BELIA_WORLD), 1);
            }
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_END_XS)) == 0 && _loc_1.zones_type == ZoneType.ZONES_XS)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._btnLeave);
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_END_XS), 1);
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            if (UILoaded && GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_END_BELIA_WORLD)) == 0 && _loc_1.zones_type == ZoneType.ZONES_BELIAL_WORLD)
            {
                GuideMultiControl.getInstance().beginGuide(int(GuideConfigObj.getInstance().FIRST_END_BELIA_WORLD));
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_END_BELIA_WORLD), 1);
            }
            if (UILoaded && GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().FIRST_END_XS)) == 0 && _loc_1.zones_type == ZoneType.ZONES_XS)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._btnLeave);
                GuideConfigObj.getInstance().saveConfigByTeam(int(GuideConfigObj.getInstance().FIRST_END_XS), 1);
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._backBlackUp = new Shape();
            this.addChild(this._backBlackUp);
            this.setChildIndex(this._backBlackUp, 0);
            this._backBlackDown = new Shape();
            this.addChild(this._backBlackDown);
            this.setChildIndex(this._backBlackDown, 0);
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._btnSure = new BaseButton(getDisplayChildByName("btn_sure"));
            this._btnLeave = new BaseButton(getDisplayChildByName("btn_leave"));
            this._magicRoll = MovieClip(getDisplayChildByName("magic_roll"));
            this._sealLevel = MovieClip(getDisplayChildByName("seal_level"));
            this._tileSuccess = MovieClip(getDisplayChildByName("tile_success"));
            this._tileDefeat = MovieClip(getDisplayChildByName("tile_defeat"));
            this._txtAwardsInfo = TextField(getDisplayChildByName("txt_awards_info"));
            this._back = MovieClip(getDisplayChildByName("back"));
            this._starContainer = getDisplayChildByName("awards_star_container") as Sprite;
            this._txtGateLeft = TextField(this._starContainer.getChildByName("txt_game_left"));
            this._freshFirstTime = MovieClip(getDisplayChildByName("fresh_first_time"));
            this._mcAwardMoney = Sprite(this._starContainer.getChildByName("mc_award_money"));
            this._mcAwardExp = Sprite(this._starContainer.getChildByName("mc_award_exp"));
            this._mcAwardSpirit = Sprite(this._starContainer.getChildByName("mc_award_spirit"));
            this._mcAwardTools = Sprite(this._starContainer.getChildByName("mc_award_tools"));
            this._playerPhoto = MovieClip(getDisplayChildByName("play_photo"));
            this._fruitExp = new ImgNumber();
            this._fruitExp.x = 175;
            this._mcAwardExp.addChild(this._fruitExp);
            this._fruitGlod = new ImgNumber();
            this._fruitGlod.x = 175;
            this._mcAwardMoney.addChild(this._fruitGlod);
            this._fruitSpirit = new ImgNumber();
            this._fruitSpirit.x = 175;
            this._mcAwardSpirit.addChild(this._fruitSpirit);
            this._awardHbox = new HBox();
            this._awardHbox.move(104, -5);
            this._awardHbox.setItemWH(52, 52);
            this._awardHbox.horizontal = true;
            this._mcAwardTools.addChild(this._awardHbox);
            this.initStarList();
            this.initCard();
            this._cardContainer.visible = false;
            return;
        }// end function

        private function initStarList() : void
        {
            this._vecStar = new Vector.<MovieClip>(5, true);
            var _loc_1:* = 0;
            while (_loc_1 < 5)
            {
                
                this._vecStar[_loc_1] = this._starContainer.getChildByName("star" + (_loc_1 + 1)) as MovieClip;
                _loc_1++;
            }
            return;
        }// end function

        private function initCard() : void
        {
            var _loc_2:* = null;
            this._cardContainer = new BaseSprite();
            this._cardContainer.move(415, 620);
            this.addChild(this._cardContainer);
            this._vecCard = new Vector.<ZonesAwardsCard>(8, true);
            var _loc_1:* = 0;
            while (_loc_1 < 8)
            {
                
                _loc_2 = new ZonesAwardsCard();
                this._vecCard[_loc_1] = _loc_2;
                _loc_2.index = _loc_1;
                this._cardContainer.addChild(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._btnSure:
                {
                    break;
                }
                case this._btnLeave:
                {
                    this.clickLeave();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.stage.addEventListener(Event.RESIZE, this.onResize);
            this.setBackMask();
            this.updatePanel();
            this.startEffect();
            TweenLite.delayedCall(60, this.callClose);
            return;
        }// end function

        private function callClose() : void
        {
            this._btnLeave.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this.stage.removeEventListener(Event.RESIZE, this.onResize);
            this._freshFirstTime.gotoAndStop(1);
            this.resetStar();
            TweenLite.killDelayedCallsTo(this.callClose);
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            this.setBackMask();
            return;
        }// end function

        private function setBackMask() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_1:* = FrameworkGlobal.stageW;
            _loc_2 = FrameworkGlobal.stageH;
            _loc_3 = this._back.width;
            var _loc_4:* = this._back.height;
            this._backBlackUp.x = (-(_loc_1 - _loc_3)) / 2;
            this._backBlackUp.y = 0;
            this._backBlackUp.graphics.clear();
            this._backBlackUp.graphics.beginFill(0, 0.5);
            this._backBlackUp.graphics.drawRect(0, 0, _loc_1, _loc_2 / 2);
            this._backBlackUp.graphics.endFill();
            this._backBlackDown.x = (-(_loc_1 - _loc_3)) / 2;
            this._backBlackDown.y = _loc_2 / 2;
            this._backBlackDown.graphics.clear();
            this._backBlackDown.graphics.beginFill(0, 0.5);
            this._backBlackDown.graphics.drawRect(0, 0, _loc_1, _loc_2 / 2 + 100);
            this._backBlackDown.graphics.endFill();
            return;
        }// end function

        private function clickLeave() : void
        {
            if (this.timeline && this.timeline.active)
            {
                this.timeline.stop();
            }
            this.leaveInstance();
            return;
        }// end function

        private function leaveInstance() : void
        {
            var _loc_1:* = ZonesModel.getInstance().zonesAwardsInfo;
            if (_loc_1.zoneid > 0)
            {
                ZonesControl.getInstance().reqZoneOut();
            }
            else
            {
                MapClientControl.getInstance().clientBackMap();
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.guidePause(GuideConfigObj.getInstance().FIRST_END_XS_1);
            this.guidePause(GuideConfigObj.getInstance().FIRST_END_BELIA_WORLD_1);
            if (this._btnLeave)
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._btnLeave);
            }
            if (this.vmcBrushLight)
            {
                this.vmcBrushLight.finalize();
                this.vmcBrushLight = null;
            }
            return;
        }// end function

        private function updatePanel() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this._awardHbox.reset();
            this.giftExp = 0;
            this.giftGold = 0;
            this.giftSpirit = 0;
            var _loc_1:* = ZonesModel.getInstance().zonesAwardsInfo;
            var _loc_2:* = new Vector.<IconItem>;
            if (_loc_1)
            {
                this.isPass = _loc_1.isPass == 1 ? (true) : (false);
                _loc_3 = 0;
                while (_loc_3 < _loc_1.itemlist.length)
                {
                    
                    _loc_6 = _loc_1.itemlist[_loc_3];
                    switch(_loc_6.itemModelId)
                    {
                        case -1:
                        {
                            this.giftGold = _loc_6.num.toNumber();
                            break;
                        }
                        case -2:
                        {
                            break;
                        }
                        case -3:
                        {
                            break;
                        }
                        case -4:
                        {
                            this.giftExp = _loc_6.num.toNumber();
                            break;
                        }
                        case -6:
                        {
                            this.giftSpirit = _loc_6.num.toNumber();
                            break;
                        }
                        default:
                        {
                            _loc_7 = new IconItem(null);
                            _loc_8 = new PropInfo();
                            _loc_8.conv(_loc_6);
                            _loc_7.needQuality = false;
                            _loc_7.setWH(42, 42);
                            _loc_7.setInfo(_loc_8);
                            _loc_2.push(_loc_7);
                            this._awardHbox.add(_loc_7, true);
                            break;
                            break;
                        }
                    }
                    _loc_3++;
                }
                _loc_4 = (UserObj.getInstance().playerInfo.job - 1) % 3 + 1;
                this._playerPhoto.gotoAndStop(_loc_4);
                this._txtGateLeft.text = ToolKit.getTimeBySecond(_loc_1.time);
                _loc_5 = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_1.zoneid);
            }
            else
            {
                this.isPass = false;
            }
            return;
        }// end function

        private function startEffect() : void
        {
            this.prepEffect();
            if (this.isPass)
            {
                this._tileSuccess.gotoAndPlay(1);
            }
            this.timeline = new TimelineLite();
            this.timeline.append(new TweenLite(this._starContainer, 0.25, {}));
            this.timeline.appendMultiple([new TweenLite(this._backBlackUp, 0.25, {y:0}), new TweenLite(this._backBlackDown, 0.25, {y:FrameworkGlobal.stageH / 2})]);
            this.timeline.append(new TweenLite(this._back, 0.2, {alpha:1}));
            this.timeline.append(new TweenLite(this._magicRoll, 0.1, {onComplete:function () : void
            {
                _magicRoll.gotoAndPlay(1);
                return;
            }// end function
            }));
            this.timeline.append(new TweenLite(this._starContainer, 0.2, {alpha:1, y:267}));
            this.timeline.append(new TweenLite(this._playerPhoto, 0.5, {alpha:1, x:72, onComplete:this.callShowGeft}));
            this.timeline.append(new TweenLite(this._starContainer, 1, {}));
            this.timeline.append(new TweenLite(this._sealLevel, 0.2, {scaleX:1, scaleY:1, ease:Back.easeOut, alpha:1, onComplete:this.callSealLevelBack}));
            if (this._awardHbox.contents.length > 0)
            {
                this.timeline.append(new TweenLite(this._awardHbox, 0.2, {alpha:1}));
            }
            return;
        }// end function

        private function callSealLevelBack() : void
        {
            var _loc_1:* = 0;
            if (!this.vmcBrushLight)
            {
                _loc_1 = ZonesModel.getInstance().zonesAwardsInfo == null ? (0) : (ZonesModel.getInstance().zonesAwardsInfo.star);
                _loc_1++;
                this.vmcBrushLight = new VMCView();
                this.vmcBrushLight.loadRes("res/effect/zones/zonesaward_" + _loc_1 + ".png");
                this.vmcBrushLight.auto = true;
                this.vmcBrushLight.updatePose("90", false, false, true, true);
                this._sealLevel.parent.addChild(this.vmcBrushLight);
                this.vmcBrushLight.move(this._sealLevel.x + this._sealLevel.width / 2, this._sealLevel.y + this._sealLevel.height / 2);
            }
            return;
        }// end function

        private function callShowGeft() : void
        {
            this.showStar();
            this._fruitGlod.setNumber(this.giftGold.toString(), 5, 0, true);
            this._fruitExp.setNumber(this.giftExp.toString(), 5, 0, true);
            if (this.giftSpirit > 0)
            {
                this._fruitSpirit.setNumber(this.giftSpirit.toString(), 5, 0, true);
            }
            if (this._awardHbox.contents.length > 0)
            {
                this._mcAwardTools.visible = true;
            }
            return;
        }// end function

        private function showStar() : void
        {
            var index:* = this.curStar;
            var lev:* = ZonesModel.getInstance().zonesAwardsInfo != null ? (ZonesModel.getInstance().zonesAwardsInfo.star) : (0);
            if (index >= 5 || index >= lev)
            {
                this.curStar = 0;
                return;
            }
            var star:* = this._vecStar[index];
            star.gotoAndStop(2);
            var ray:* = new VMCView();
            ray.move(24, 24);
            star.addChild(ray);
            ray.loadRes("res/effect/zones/zonesstarray.png");
            ray.auto = true;
            ray.updatePose("90", false, false, true, true);
            var _loc_2:* = this;
            var _loc_3:* = this.curStar + 1;
            _loc_2.curStar = _loc_3;
            TweenLite.delayedCall(0.2, function () : void
            {
                showStar();
                return;
            }// end function
            );
            return;
        }// end function

        private function resetStar() : void
        {
            var index:* = this.curStar;
            if (index >= 5)
            {
                this.curStar = 0;
                return;
            }
            var star:* = this._vecStar[index];
            star.gotoAndStop(1);
            TweenLite.delayedCall(0.1, function () : void
            {
                var _loc_2:* = curStar + 1;
                curStar = _loc_2;
                resetStar();
                return;
            }// end function
            );
            return;
        }// end function

        private function prepEffect() : void
        {
            this._backBlackUp.y = -this._backBlackUp.height;
            this._backBlackDown.y = FrameworkGlobal.stageH;
            this._starContainer.alpha = 0;
            this._starContainer.y = 267 + 20;
            this._playerPhoto.x = 72 - 300;
            this._playerPhoto.alpha = 0;
            this._magicRoll.gotoAndStop(1);
            this._back.alpha = 0;
            this._sealLevel.alpha = 0;
            this._sealLevel.scaleX = 1.5;
            this._sealLevel.scaleY = 1.5;
            this._cardContainer.alpha = 0;
            var _loc_1:* = ZonesModel.getInstance().zonesAwardsInfo == null ? (0) : (ZonesModel.getInstance().zonesAwardsInfo.star);
            this._sealLevel.gotoAndStop((_loc_1 + 1));
            this._fruitExp.setNumber("0", 5);
            this._fruitGlod.setNumber("0", 5);
            this._fruitSpirit.setNumber("0", 5);
            this._awardHbox.alpha = 0;
            this._mcAwardSpirit.visible = this.giftSpirit > 0;
            this._mcAwardTools.visible = this._awardHbox.contents.length > 0;
            return;
        }// end function

        public function get isPass() : Boolean
        {
            return this._isPass;
        }// end function

        public function set isPass(param1:Boolean) : void
        {
            this._isPass = param1;
            if (param1)
            {
                this._tileDefeat.visible = false;
                this._tileSuccess.visible = true;
            }
            else
            {
                this._tileDefeat.visible = true;
                this._tileSuccess.visible = false;
            }
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this._btnLeave, this, GuideConfigObj.getInstance().FIRST_END_XS_1);
            GuideMultiControl.getInstance().registerGuide(this._btnLeave, this, GuideConfigObj.getInstance().FIRST_END_BELIA_WORLD_1);
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
            return UILoaded;
        }// end function

    }
}
