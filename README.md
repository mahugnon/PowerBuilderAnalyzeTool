# PowerBuilderAnalyzeTool
```Smalltalk
Metacello new
   	githubUser: 'mahugnon' project: 'PowerBuilderAnalyzeTool' commitish: 'master' path: 'src';
   	baseline: 'PWBCodeAnalyser';
    onConflict: [ :e | e useIncoming ];
       onUpgrade: [ :e | e useIncoming ];
       
   	load
    
    ```
