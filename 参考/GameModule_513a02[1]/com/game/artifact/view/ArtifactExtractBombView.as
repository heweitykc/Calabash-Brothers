package com.game.artifact.view
{
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.vmc.*;
    import com.greensock.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ArtifactExtractBombView extends BaseSprite
    {
        private var itemView:Image;
        private var bombMovie:VMCView;
        private var item:PropInfo;
        private var bombOkCallback:Function;
        private var moveComplete:Boolean = false;
        private var bombLoadComplete:Boolean = false;

        public function ArtifactExtractBombView(param1:DisplayObjectContainer, param2:Point, param3:Point, param4:PropInfo, param5:Function)
        {
            var _loc_8:* = NaN;
            this.item = param4;
            this.bombOkCallback = param5;
            this.itemView = new Image();
            this.itemView.load(param4.url);
            addChild(this.itemView);
            this.bombMovie = new VMCView();
            this.bombMovie.loadRes("res/effect/artifact/bomb.png", null, true, this.onBombLoadComplete);
            var _loc_6:* = param2.x - param3.x;
            var _loc_7:* = param2.y - param3.y;
            _loc_8 = Math.sqrt(_loc_6 * _loc_6 + _loc_7 * _loc_7);
            x = param2.x;
            y = param2.y;
            param1.addChild(this);
            new TweenLite(this, _loc_8 / 300, {x:param3.x, y:param3.y, onComplete:this.onMoveComplete});
            return;
        }// end function

        private function onBombLoadComplete() : void
        {
            this.bombLoadComplete = true;
            this.tryBeginBomb();
            return;
        }// end function

        private function onMoveComplete() : void
        {
            this.moveComplete = true;
            this.tryBeginBomb();
            return;
        }// end function

        private function tryBeginBomb() : void
        {
            if (this.bombLoadComplete && this.moveComplete)
            {
                this.beginBomb();
            }
            return;
        }// end function

        private function beginBomb() : void
        {
            removeChild(this.itemView);
            addChild(this.bombMovie);
            this.bombMovie.move(this.itemView.width / 2, this.itemView.height / 2);
            this.bombMovie.addEventListener(Event.COMPLETE, this.onBombComplete);
            this.bombMovie.auto = true;
            this.bombMovie.updatePose("90", false);
            this.bombMovie.play();
            return;
        }// end function

        private function onBombComplete(event:Event) : void
        {
            this.bombMovie.removeEventListener(Event.COMPLETE, this.onBombComplete);
            parent.removeChild(this);
            this.bombOkCallback(this.item);
            return;
        }// end function

    }
}
