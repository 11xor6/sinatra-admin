package ness.sinatra.admin;

import org.jruby.Main;

public class SinatraRunner
{
    public static void main(String[] args)
    {
        Main.main(new String[]{"-e", "require 'rubygems'", "-e", "require 'jetty-rackup'"});
    }
}
