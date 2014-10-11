package com.game.dragonking.control
{
    import com.*;
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.dragonking.*;
    import com.game.map.control.*;
    import com.game.player.model.*;
    import com.game.role.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.utils.*;

    public class FlashControl extends Object implements IPhaseControl
    {
        private var _frameCount:int;
        private var _glowerFilter:GlowFilter;
        private var _frontView:VMCView;
        private var _backView:VMCView;
        private var _lastTime:int;
        private var bg:Sprite;
        private var _movie:MovieClip;

        public function FlashControl()
        {
            return;
        }// end function

        public function start() : void
        {
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.__enterframe, false, 0, true);
            this._frameCount = 0;
            this._glowerFilter = new GlowFilter(16777150, 1, 0, 0, 2.5);
            var _loc_1:* = RoleList.getInstance().player as Player;
            return;
        }// end function

        private function __enterframe(event:Event) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._lastTime > 83)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._frameCount + 1;
                _loc_3._frameCount = _loc_4;
                if (this._frameCount == 1)
                {
                    this._frontView = new VMCView();
                    this._frontView.auto = true;
                    this._frontView.updatePose("front_90", false, false, true);
                    this._frontView.loadRes("res/effect/transform.png");
                    this._backView = new VMCView();
                    this._backView.auto = true;
                    this._backView.updatePose("back_90", false, false, true);
                    this._frontView.loadRes("res/effect/transform.png");
                    RoleList.getInstance().player.getSprite().addChild(this._frontView);
                    RoleList.getInstance().player.getSprite().addChild(this._backView);
                }
                if (this._frameCount < 10)
                {
                    this._glowerFilter.blurX = this._glowerFilter.blurX + 2.4;
                    this._glowerFilter.blurY = this._glowerFilter.blurY + 2.4;
                    (RoleList.getInstance().player as Player).bodyView.filters = [this._glowerFilter];
                }
                else if (this._frameCount == 10)
                {
                }
                else if (this._frameCount == 20)
                {
                    RoleList.getInstance().player.visible = false;
                    this._frontView.finalize();
                    this._backView.finalize();
                }
                else if (this._frameCount == 22)
                {
                    RoleList.getInstance().player.visible = true;
                    this.updateAttribute();
                    this._glowerFilter.blurX = this._glowerFilter.blurX - 2.4;
                    this._glowerFilter.blurY = this._glowerFilter.blurY - 2.4;
                    (RoleList.getInstance().player as Player).bodyView.filters = [this._glowerFilter];
                }
                else if (this._frameCount > 21 && this._frameCount < 31)
                {
                    this._glowerFilter.blurX = this._glowerFilter.blurX - 2.4;
                    this._glowerFilter.blurY = this._glowerFilter.blurY - 2.4;
                    (RoleList.getInstance().player as Player).bodyView.filters = [this._glowerFilter];
                }
                else if (this._frameCount == 31)
                {
                    FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.__enterframe);
                    (RoleList.getInstance().player as Player).bodyView.filters = [];
                    this.addVideo();
                }
                this._lastTime = _loc_2;
            }
            return;
        }// end function

        private function addVideo() : void
        {
            this.bg = new Sprite();
            this.bg.graphics.beginFill(0);
            this.bg.graphics.drawRect(0, 0, FrameworkGlobal.stageW, FrameworkGlobal.stageH);
            this.bg.graphics.endFill();
            Global.popManager.cueMaskLayer.addChild(this.bg);
            VResManager.load("res/video/dragonking.swf", this.onComplete);
            TweenLite.delayedCall(3, this.end);
            return;
        }// end function

        private function onComplete(param1:MovieClip) : void
        {
            this._movie = ToolKit.getNew("dragonking_end");
            this._movie.addEventListener(Event.COMPLETE, this.__complete);
            this._movie.addEventListener(Event.ENTER_FRAME, this.__movieEnter);
            Global.popManager.addBgMask(false);
            Global.popManager.txtLayer.addChild(this._movie);
            this._movie.x = FrameworkGlobal.stageW * 0.5;
            this._movie.y = FrameworkGlobal.stageH * 0.5 - 200;
            return;
        }// end function

        private function __movieEnter(event:Event) : void
        {
            if (this._movie)
            {
                if (this._movie.currentFrame == this._movie.totalFrames)
                {
                    if (this._movie.parent)
                    {
                        this._movie.stop();
                    }
                }
            }
            return;
        }// end function

        private function __complete(event:Event) : void
        {
            if (event.target.parent)
            {
                event.target.parent.removeChild(event.target);
            }
            return;
        }// end function

        private function updateAttribute() : void
        {
            var _loc_1:* = EquipsObj.getInstance().getEquipBy(1);
            var _loc_2:* = EquipsObj.getInstance().getEquipBy(2);
            var _loc_3:* = EquipsObj.getInstance().getEquipBy(Params.BODY);
            var _loc_4:* = EquipsObj.getInstance().getEquipBy(Params.WING);
            MapClientControl.getInstance().addWeapon(_loc_1.itemModelId, Params.LEFT_WEAPON);
            MapClientControl.getInstance().addWeapon(_loc_2.itemModelId, Params.RIGHT_WEAPON);
            MapClientControl.getInstance().addArmor(_loc_3.itemModelId, Params.BODY);
            MapClientControl.getInstance().addWing(_loc_4.itemModelId, Params.WING);
            return;
        }// end function

        public function removeBg() : void
        {
            if (this._movie && this._movie.parent)
            {
                this._movie.parent.removeChild(this._movie);
                this._movie.removeEventListener(Event.ENTER_FRAME, this.__movieEnter);
                this._movie = null;
            }
            if (this.bg && this.bg.parent)
            {
                this.bg.parent.removeChild(this.bg);
            }
            return;
        }// end function

        public function end() : void
        {
            DragonKingController.getInstance().nextRound();
            return;
        }// end function

    }
}
