package com.sixtyfour.templating;

import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import com.sixtyfour.Logger;


/**
 * Manages templates bound to threads. For each thread, you'll get an individual template instance. If the template file
 * has changed on disk, a new instance will be created. Otherwise, the existing instance for a thread will be recycled.
 * 
 * @author EgonOlsen
 *
 */
public class TemplateManager
{
  private Map<TemplateInfo, ThreadLocal<Template>> templates = new HashMap<TemplateInfo, ThreadLocal<Template>>();
  private Map<String, TemplateInfo> templateInfos = new HashMap<String, TemplateInfo>();


  public TemplateManager()
  {
    //
  }


  /**
   * Returns a template instance for the given path and the current thread
   * 
   * @param pathToTemplate
   * @return the template instance
   */
  public Template getTemplate(String pathToTemplate)
  {
    TemplateInfo existing = templateInfos.get(pathToTemplate);
    if (existing == null)
    {
      existing = new TemplateInfo(pathToTemplate);
      ThreadLocal<Template> tl = new ThreadLocal<Template>();
      templates.put(existing, tl);

      return createTemplate(pathToTemplate, existing, tl);
    }
    else
    {
      if (existing.hasChanged())
      {
        templates.remove(existing);
      }

      ThreadLocal<Template> tl = templates.get(existing);
      if (tl == null)
      {
        tl = new ThreadLocal<Template>();
        templates.put(existing, tl);
        return createTemplate(pathToTemplate, existing, tl);
      }
      else
      {
        Template tmpl = tl.get();
        if (tmpl == null)
        {
          return createTemplate(pathToTemplate, existing, tl);
        }
        return tmpl;
      }
    }
  }


  private Template createTemplate(String pathToTemplate, TemplateInfo existing, ThreadLocal<Template> tl)
  {
    try
    {
      Logger.log("Creating new template instance for " + pathToTemplate);
      Template tmpl = TemplateFactory.getTemplate(new FileInputStream(pathToTemplate), null);
      tl.set(tmpl);
      existing.setBasicCode(tmpl.getBasicCode());
      return tmpl;
    }
    catch (Exception e)
    {
      throw new RuntimeException("Unable to instantiate template: " + pathToTemplate, e);
    }
  }

}