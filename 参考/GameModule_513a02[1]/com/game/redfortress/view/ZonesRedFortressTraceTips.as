package com.game.redfortress.view
{
    import com.f1.utils.*;
    import com.view.tipcell.*;
    import flash.display.*;

    public class ZonesRedFortressTraceTips extends BaseTips
    {
        private var _contect:MovieClip;

        public function ZonesRedFortressTraceTips()
        {
            this.initComp();
            return;
        }// end function

        private function initComp() : void
        {
            this._contect = ToolKit.getNew("zones_redfortress_trace_detail_tips");
            this.addChild(this._contect);
            return;
        }// end function

    }
}
