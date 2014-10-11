package com.game.artifact.view
{
    import com.f1.ui.tips.*;
    import com.game.artifact.locale.*;
    import com.game.artifact.model.*;
    import com.model.vo.*;
    import com.view.tipcell.*;
    import flash.display.*;

    public class ArtifactExtractPanelEquipTips extends EquipTips
    {
        private var doubleExtractTips:Sprite;

        public function ArtifactExtractPanelEquipTips()
        {
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            super.repaint(param1);
            this.disposeDoubleExtractTips();
            if (ArtifactExtractPanel.isDoubleExtractMode)
            {
                _loc_2 = param1 as EquipmentInfo;
                _loc_3 = ArtifactData.getInstance();
                _loc_4 = _loc_3.computeDoubleExtractCostGold(_loc_2);
                _loc_5 = _loc_3.computeDoubleExtractExp(_loc_2);
                _loc_6 = ArtifactText.tipDoubleExtractOneItem(_loc_4, _loc_5);
                this.doubleExtractTips = StringTip.newTipSp(_loc_6);
                this.doubleExtractTips.y = height + 1;
                addChild(this.doubleExtractTips);
            }
            return;
        }// end function

        private function disposeDoubleExtractTips() : void
        {
            if (this.doubleExtractTips)
            {
                removeChild(this.doubleExtractTips);
                this.doubleExtractTips = null;
            }
            return;
        }// end function

    }
}
