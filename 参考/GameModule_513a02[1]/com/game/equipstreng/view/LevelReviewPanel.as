package com.game.equipstreng.view
{
    import com.f1.ui.*;
    import flash.display.*;

    public class LevelReviewPanel extends Component
    {
        private var mc_cur1:MovieClip;
        private var mc_cur2:MovieClip;
        private var mc_next1:MovieClip;
        private var mc_next2:MovieClip;
        private var mc_arrow:MovieClip;

        public function LevelReviewPanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.mc_cur1 = getDisplayChildByName("mc_cur1");
            this.mc_cur2 = getDisplayChildByName("mc_cur2");
            this.mc_next1 = getDisplayChildByName("mc_next1");
            this.mc_next2 = getDisplayChildByName("mc_next2");
            this.mc_arrow = getDisplayChildByName("mc_arrow");
            return;
        }// end function

        public function showLevel(param1:int, param2:int) : void
        {
            if (param1 >= 10)
            {
                this.mc_cur1.visible = true;
                this.mc_cur2.visible = true;
                this.mc_cur1.gotoAndStop(3);
                this.mc_cur2.gotoAndStop(param1 - 10 + 2);
            }
            else
            {
                this.mc_cur1.visible = false;
                this.mc_cur2.visible = true;
                this.mc_cur2.gotoAndStop(param1 + 2);
            }
            if (param2 >= 10)
            {
                this.mc_next1.visible = true;
                this.mc_next2.visible = true;
                this.mc_next1.gotoAndStop(3);
                this.mc_next2.gotoAndStop(param2 - 10 + 2);
            }
            else
            {
                this.mc_next1.visible = true;
                this.mc_next2.visible = false;
                this.mc_next1.gotoAndStop(param2 + 2);
            }
            return;
        }// end function

    }
}
