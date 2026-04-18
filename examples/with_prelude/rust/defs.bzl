def _rule_with_custom_span(ctx: AnalysisContext) -> list[Provider]:
    output = ctx.actions.declare_output("output", has_content_based_path = False)
    target = ctx.attrs.target
    ctx.actions.run(
        cmd_args(target[RunInfo], cmd_args(output.as_output())),
        category = "target_run_with_custom_span",
    )
    return [
        DefaultInfo(output),
    ]


_rule_with_custom_span = rule(
    impl = _rule_with_custom_span,
    attrs = {
        "target": attrs.exec_dep(),
    },
    doc = """
    Creates a rule that can execute multiple targets in sequence and output custom events to buck cli ui.
    """,
)

def rule_with_custom_span(
    name: str,
    target: str,
    **kwargs
): 
    _rule_with_custom_span(
        name = name,
        target = target,
        **kwargs
    )
