package com.game.artifact.view
{
    import com.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;

    public class ArtifactHighlightBorder extends Sprite
    {
        private var container:DisplayObjectContainer;
        private var panel:DisplayObject;
        public var panelClickTip:String;
        private var showing:Boolean = false;

        public function ArtifactHighlightBorder(param1:DisplayObject, param2:DisplayObjectContainer, param3:int, param4:int, param5:int, param6:int)
        {
            this.panel = param1;
            this.container = param2;
            mouseChildren = false;
            mouseEnabled = false;
            x = param3 - 1;
            y = param4 - 1;
            graphics.clear();
            graphics.lineStyle(2, 16763904);
            graphics.drawRoundRect(0, 0, param5 + 2, param6 + 2, 2, 2);
            graphics.endFill();
            return;
        }// end function

        public function show() : void
        {
            if (!this.showing)
            {
                this.showing = true;
                this.container.addChild(this);
                this.panel.addEventListener(MouseEvent.CLICK, this.onPanelClick);
                alpha = 0.3;
                this.blink();
            }
            return;
        }// end function

        public function hide() : void
        {
            if (this.showing)
            {
                this.showing = false;
                TweenLite.killTweensOf(this);
                this.container.removeChild(this);
                this.panel.removeEventListener(MouseEvent.CLICK, this.onPanelClick);
            }
            return;
        }// end function

        private function blink() : void
        {
            var _loc_1:* = NaN;
            if (Math.abs(alpha - 0.3) < 0.01)
            {
                _loc_1 = 1;
            }
            else if (Math.abs((alpha - 1)) < 0.01)
            {
                _loc_1 = 0.3;
            }
            TweenLite.to(this, 1, {alpha:_loc_1, onComplete:this.blink});
            return;
        }// end function

        private function onPanelClick(event:MouseEvent) : void
        {
            Global.popManager.addedToMouseCue(this.panelClickTip);
            return;
        }// end function

    }
}
