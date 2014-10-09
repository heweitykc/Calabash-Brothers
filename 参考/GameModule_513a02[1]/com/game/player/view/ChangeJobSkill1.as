package com.game.player.view
{
    import com.f1.ui.*;
    import flash.display.*;

    public class ChangeJobSkill1 extends Component
    {

        public function ChangeJobSkill1()
        {
            loadDisplay("res/changejobvideo1.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("changeJob1");
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
            if (UILoaded)
            {
                (this.getDisplay() as MovieClip).gotoAndStop(param1);
            }
            return;
        }// end function

    }
}
