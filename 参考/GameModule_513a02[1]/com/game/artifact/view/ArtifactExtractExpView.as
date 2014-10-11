package com.game.artifact.view
{
    import com.f1.*;
    import com.greensock.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class ArtifactExtractExpView extends TextField
    {
        private var startY:int;
        private var endY:int;
        private var exps:Array;
        private var tweenLite:TweenLite;
        private static var expColorDict:Dictionary = new Dictionary();
        private static var expSteps:Array = [3000, 2000, 0];
        private static var shortDuration:Number = 0.3;
        private static var longDuration:Number = 1;

        public function ArtifactExtractExpView(param1:Point)
        {
            this.exps = new Array();
            this.startY = param1.y;
            this.endY = this.startY - 50;
            x = param1.x;
            y = this.startY;
            visible = false;
            defaultTextFormat = new TextFormat(LanguageCfgObj.getInstance().getByIndex("10215"), 32, null, true);
            filters = [FrameworkGlobal.BLACK_FILTER];
            autoSize = TextFieldAutoSize.LEFT;
            return;
        }// end function

        public function show(param1:Number) : void
        {
            this.exps.push(param1);
            if (this.exps.length == 1)
            {
                visible = true;
                this.showNext();
            }
            else
            {
                this.tweenLite.duration = shortDuration;
            }
            return;
        }// end function

        private function showNext() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = 0;
            var _loc_3:* = NaN;
            _loc_1 = this.exps[0];
            for each (_loc_3 in expSteps)
            {
                
                if (_loc_1 >= _loc_3)
                {
                    _loc_2 = expColorDict[_loc_3];
                    break;
                }
            }
            text = "+" + _loc_1;
            textColor = _loc_2;
            y = this.startY;
            alpha = 1;
            this.tweenLite = new TweenLite(this, this.exps.length == 1 ? (longDuration) : (shortDuration), {alpha:0.3, y:this.endY, onComplete:this.onShowComplete});
            return;
        }// end function

        private function onShowComplete() : void
        {
            this.tweenLite = null;
            this.exps.shift();
            if (this.exps.length > 0)
            {
                this.showNext();
            }
            else
            {
                visible = false;
            }
            return;
        }// end function

        expColorDict[3000] = 2031360;
        expColorDict[2000] = 16748800;
        expColorDict[0] = 49407;
    }
}
