package com.game.equipstreng.view
{
    import com.f1.ui.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import flash.display.*;

    public class ScorePanel extends Component
    {
        private var imageNumber:ImgNumber;
        private var imageNumberAdd:ImgNumber;
        private var mc_fightNumber:MovieClip;
        private var mc_fightNumberAdd:MovieClip;
        private var mc_add:MovieClip;
        private var mc5:MovieClip;

        public function ScorePanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.imageNumber = new ImgNumber();
            addChild(this.imageNumber);
            this.imageNumberAdd = new ImgNumber();
            addChild(this.imageNumberAdd);
            this.mc_fightNumber = getDisplayChildByName("mc_fightNumber");
            this.mc_fightNumberAdd = getDisplayChildByName("mc_fightNumberAdd");
            this.mc_add = getDisplayChildByName("mc_add");
            this.mc5 = getDisplayChildByName("mc5");
            return;
        }// end function

        public function setNumber(param1:String, param2:int = 0, param3:int = 0, param4:Boolean = false, param5:Boolean = false, param6:String = "") : void
        {
            this.imageNumber.setNumber(param1, param2, param3, param4, param5, param6);
            this.imageNumber.x = this.mc_fightNumber.x - this.imageNumber.width;
            this.imageNumber.y = this.mc_fightNumber.y;
            return;
        }// end function

        public function setAddedNumber(param1:String, param2:int = 0, param3:int = 0, param4:Boolean = false, param5:Boolean = false, param6:String = "") : void
        {
            this.imageNumberAdd.setNumber(param1, param2, param3, param4, param5, param6);
            this.imageNumberAdd.x = this.mc_fightNumberAdd.x;
            this.imageNumberAdd.y = this.mc_fightNumberAdd.y + 2;
            this.updateLayout();
            return;
        }// end function

        public function updateLayout() : void
        {
            this.mc5.x = this.imageNumberAdd.x + this.imageNumberAdd.width + 2;
            return;
        }// end function

    }
}
