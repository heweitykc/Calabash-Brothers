package com.game.protect.view
{
    import com.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;

    public class ProtectBaseBox extends BaseBox
    {
        private var layerType:uint;
        private var layoutInfo:LayoutInfo;
        private var hasAddedToPop:Boolean = false;
        static const LAYER_POP:uint = 1;
        static const LAYER_POPUP:uint = 2;
        static const LAYER_CUE:uint = 3;

        public function ProtectBaseBox(param1:uint = 3, param2:LayoutInfo = null)
        {
            this.layerType = param1;
            if (param1 == LAYER_POPUP)
            {
                if (param2 == null)
                {
                    param2 = new LayoutInfo(Layout.CENTER);
                }
                this.layoutInfo = param2;
            }
            return;
        }// end function

        override public function open() : void
        {
            if (isOpen)
            {
                return;
            }
            if (this.layerType == LAYER_POP || this.layerType == LAYER_CUE)
            {
                if (!this.hasAddedToPop)
                {
                    this.hasAddedToPop = true;
                    if (this.layerType == LAYER_POP)
                    {
                        Global.popManager.addPop(this);
                    }
                    else
                    {
                        Global.popManager.addPop(this, true, true, true, true, false, true);
                    }
                }
            }
            super.open();
            if (this.layerType == LAYER_POPUP)
            {
                Global.popManager.addUI(this, this.layoutInfo);
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            if (this.layerType == LAYER_POPUP)
            {
                Global.popManager.removeUI(this);
            }
            return;
        }// end function

    }
}
