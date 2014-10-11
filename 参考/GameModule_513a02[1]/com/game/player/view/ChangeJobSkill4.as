package com.game.player.view
{
    import com.f1.ui.*;
    import flash.display.*;
    import flash.events.*;

    public class ChangeJobSkill4 extends Component
    {

        public function ChangeJobSkill4()
        {
            loadDisplay("res/changejobvideo4.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("changeJob4");
            this.initUI();
            this.addListener();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            return;
        }// end function

        private function addListener() : void
        {
            return;
        }// end function

        public function showSkill(param1:int = 1) : void
        {
            var _loc_2:* = null;
            if (UILoaded)
            {
                (this.getDisplay() as MovieClip).gotoAndStop(param1);
                _loc_2 = MovieClip((this.getDisplay() as MovieClip).getChildAt(0));
                _loc_2.play();
                _loc_2.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = event.target as MovieClip;
            if (_loc_2.currentFrame == _loc_2.totalFrames)
            {
            }
            return;
        }// end function

    }
}
