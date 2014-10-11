package com.game.artifact.view
{
    import com.f1.*;
    import com.f1.vmc.*;
    import com.game.artifact.cfg.*;
    import flash.events.*;

    public class ArtifactPhotoView extends BaseSprite
    {
        private var movie:VMCView;
        private var downing:Boolean;
        private var curFrame:uint;
        private static var footX:int = 145;
        private static var footY:int = 240;
        private static var minY:int = footY - 5;
        private static var maxY:int = footY + 5;
        private static var yDif:int = 1;
        private static var framesPerUpdate:uint = 3;

        public function ArtifactPhotoView()
        {
            this.movie = new VMCView();
            this.movie.auto = true;
            this.movie.move(footX, footY);
            addChild(this.movie);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedToStage);
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.movie.move(footX, footY);
            this.downing = true;
            this.curFrame = 0;
            return;
        }// end function

        private function onRemovedToStage(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = this;
            this.curFrame = (this.curFrame + 1);
            _loc_3.curFrame = this.curFrame + 1;
            if (this.curFrame < framesPerUpdate)
            {
                return;
            }
            this.curFrame = 0;
            if (this.downing)
            {
                _loc_2 = this.movie._y + yDif;
                if (_loc_2 >= maxY)
                {
                    _loc_2 = maxY;
                    this.downing = false;
                }
            }
            else
            {
                _loc_2 = this.movie._y - yDif;
                if (_loc_2 <= minY)
                {
                    _loc_2 = minY;
                    this.downing = true;
                }
            }
            this.movie._y = _loc_2;
            return;
        }// end function

        public function setArtifact(param1:ArtifactPropertyCfg) : void
        {
            if (param1)
            {
                this.setUrl(param1.photoUrl);
            }
            else
            {
                this.movie.finalize();
            }
            return;
        }// end function

        public function setUrl(param1:String) : void
        {
            this.movie.loadRes(param1, null, true);
            this.movie.updatePose("90", true);
            return;
        }// end function

    }
}
