package com.riaidea.text.plugins
{
    import com.riaidea.text.*;

    public interface IRTFPlugin
    {

        public function IRTFPlugin();

        function setup(param1:RichTextField) : void;

        function get enabled() : Boolean;

        function set enabled(param1:Boolean) : void;

    }
}
