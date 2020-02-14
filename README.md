# PowerBuilderAnalyzeTool
```Smalltalk
Metacello new
   githubUser: 'mahugnon' project: 'PowerBuilderAnalyzeTool' commitish: 'master' path: 'src';
   baseline: 'PowerBuilderAnalyzeTool';
   onConflict: [ :e | e useIncoming ];
   onUpgrade: [ :e | e useIncoming ];       
   load   
```
##Todo list
- [ ] Tag  librabries to indicate the domain they belong  to
   - This will allow  to automate loading of the domain to study
  
- [ ] Tag function as Dead or not
